**********************************************************
* NOME.....: !STRUCW.PRG                                 *
* FUNCAO...: StrucWindow()                               *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: StrucWindow( [<cDBF>, <cColor>] )           *
* DESCRI€AO: Abre uma Janela com a estrutura de um DBF   *
**********************************************************
Function StrucWindow( cDBF, cColor )
LOCAL cCor:=SetColor(),nLin:=Row(),nCol:=Col(),nCurs:=SetCursor()
LOCAL cTela,aCpos,nIdx,cAux
PRIVATE aBarra,nQtdItens
If (ValType(cDBF)#"C".or.Empty(cDBF)).and. ! Used()
   Return("")
Endif
If ValType(cColor)#"C"
   SetColor("w+/b,b/w")
Else
   SetColor(cColor)
Endif
aCpos:=StrucArray(cDBF)
If Empty(aCpos)
   Return("")
Endif
nQtdItens:=Len(aCpos)
cTela:=SaveScreen(3,3,MaxRow()-2,34)
Explode(3,3,MaxRow()-3,33,3)
BoxShadow(3,3,MaxRow()-3,33)
@ 5,4 to 5,32
aBarra:=ScrollBarNew(6,32,MaxRow()-4,"w+/n",1)
ScrollBarDisplay(aBarra)
ScrollBarUpdate(aBarra,1,nQtdItens,.t.)
@ 4,4 Say PadC(If(Len(cDBF)>29,FileBase(cDBF)+"."+FileExt(cDBF),cDBF),29)
nIdx:=aChoice(6,5,MaxRow()-4,30,aCpos,.t.,"_FileW")
RestScreen(3,3,MaxRow()-2,34,cTela)
SetColor( cCor )
SetCursor( nCurs )
SetPos( nLin, nCol )
Return( If(nIdx>0,{SubStr(aCpos[nIdx],2,10),;
                   SubStr(aCpos[nIdx],15,1),;
                   Val(SubStr(aCpos[nIdx],19,3)),;
                   Val(SubStr(aCpos[nIdx],24,2))},{}) )
**********************************
Static Function StrucArray( cDBF )
**********************************
LOCAL aCpos:={},aStructure
If Used()
   aStructure:=DBStruct()
Else
   Use (cDBF) SHARED NEW

   If NetErr()
      Msg("Arquivo est  sendo utilizado na Rede! - Tecle Algo", .t.)
      Return({})
   Endif
   aStructure:=DBStruct()
   Use
Endif
aEval(aStructure,{|cpo|;
      aAdd(aCpos," "+PadR(cpo[1],10)+"   "+cpo[2]+"   "+StrZero(cpo[3],3)+"  "+;
      If(cpo[2]=="N",StrZero(cpo[4],2),"  "))})
Return (aCpos)
