**********************************************************
* NOME.....: !FILEW.PRG                                  *
* FUNCAO...: FileWindow()                                *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: FileWindow( [<cDir>, <cColor>] )            *
* DESCRI€AO: Abre uma Janela para escolha de Arquivos    *
**********************************************************
Static oBarra,nQtdItens
***********************************
Function FileWindow( cDir, cColor )
***********************************
LOCAL cCor:=SetColor(),nLin:=Row(),nCol:=Col(),nCurs:=SetCursor()
LOCAL cTela,aArqs,nIdx,cFileSpec,cAux
If ValType(cDir)#"C".or.Empty(cDir)
   cDir:=NomeDir()+If(Right(NomeDir(),1)#"\","\","")+"*.*"
ElseIf FilePath(cDir)==""
   cDir:=NomeDir()+If(Right(NomeDir(),1)#"\","\","")+cDir
Endif
If ValType(cColor)#"C"
   SetColor("w+/b,b/w")
Else
   SetColor(cColor)
Endif
aArqs:=FileArray(cDir)
If Empty(aArqs)
   Return("")
Endif
cFileSpec:=FileBase(cDir)+"."+FileExt(cDir)
nQtdItens:=Len(aArqs)
cTela:=SaveScreen(3,3,MaxRow()-2,34)
Explode(3,3,MaxRow()-3,33,3)
BoxShadow(3,3,MaxRow()-3,33)
@ 5,4 to 5,32
oBarra:=ScrollBar(6,MaxRow()-4,32)
oBarra:total:=nQtdItens
oBarra:current:=1
oBarra:display()
Do While .t.
   @ 4,4 Say PadC(cDir,29)
   @ 6,6 Clear to MaxRow()-4,29
   nIdx:=aChoice(6,6,MaxRow()-4,29,aArqs,.t.,"_FileW")
   If LastKey()=27
      Exit
   ElseIf Chr(24)$aArqs[nIdx] // Diretorio Anterior
      cAux:=Left(cDir,RAT("\",cDir)-1)
      cDir:=Left(cAux,RAT("\",cAux))+cFileSpec
   ElseIf Chr(25)$aArqs[nIdx] // Diretorio Posterior
      cDir:=FilePath(cDir)+SubStr(aArqs[nIdx],2)+"\"+cFileSpec
   Else
      Exit
   Endif
   aArqs:=FileArray(cDir)
   nQtdItens:=Len(aArqs)
EndDo
RestScreen(3,3,MaxRow()-2,34,cTela)
SetColor( cCor )
SetCursor( nCurs )
SetPos( nLin, nCol )
Return( If(nIdx>0,FilePath(cDir)+aArqs[nIdx],"") )
***************************************
Function _FileW( nModo, nItem, nLinha )
***************************************
If nModo=0
   oBarra:total:=nQtdItens
   oBarra:current:=nItem
   oBarra:update()
ElseIf LastKey()=13
   Return(1)
ElseIf LastKey()=27
   Return(0)
Endif
Return(2)
*********************************
Static Function FileArray( cDir )
*********************************
LOCAL aArqs:={},aDiretorio
aDiretorio:=Directory(FilePath(cDir)+"*.*","D")
aEval(aDiretorio,{|arq| If(arq[1]==".".or.arq[5]#"D",.f.,aAdd(aArqs,;
      If(arq[1]="..",Chr(24),Chr(25))+arq[1]))})
aDiretorio:=Directory(cDir)
aEval(aDiretorio,{|arq| aAdd(aArqs,arq[1])})
aSort(aArqs)
Return (aArqs)
