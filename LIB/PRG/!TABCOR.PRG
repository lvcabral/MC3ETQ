*ีออออออออออออออออออออออออออออออออออออออออออออออออออออธ
*ณ NOME.....: !TABCOR.PRG                             ณ
*ณ FUNCAO...: TABCores()                              ณ
*ณ AUTOR....: MARCELO LEAL LIMAVERDE CABRAL           ณ
*ณ SINTAXE..: TABCores()                              ณ
*ณ DESCRI€O: Mostra a Tabela de Cores em uma Janela  ณ
*ิออออออออออออออออออออออออออออออออออออออออออออออออออออพ
Function TabCores()
LOCAL cCor,nCursor,cTela,nPag,cC,nC,nL,nTecla,nSL,nSC
STATIC nLin:=3,nCol:=6,nAtr
If nAtr==NIL
   nAtr:=ColorToN(SetColor())
Endif
cCor:=SetColor()
nCursor:=SetCursor()
nSL:=Row()
nSC:=Col()
nPag:=1
SetColor("w+/b")
SetCursor(0)
cTela=SAVESCREEN(nLin,nCol,nLin+18,nCol+67)
@ nLin,nCol Clear to nLin+17,nCol+66
Janela(nLin,nCol,nLin+17,nCol+66)
BoxShadow(nLin,nCol,nLin+17,nCol+66)
cC:=0
For nL=1 to 16
   For nC=2 to 64 Step 4
      @ nLin+nL,nCol+nC Say StrZero(cC,3) Color NtoColor(cC,.t.)
      cC++
   Next
Next
nL:=Ceiling((nAtr+1)/16)
nC:=nAtr
Do While nC>=16
   nC-=16
EndDo
nC*=4
Do While .T.
   @ nLin+nL,nCol+nC+1 Say Chr(175) Color "gr+/b"
   @ nLin+nL,nCol+nC+5 Say Chr(174) Color "gr+/b"
   nTecla=InKey(0)
   Do Case
   Case nTecla=4               &&---------------> [-->]
      @ nLin+nL,nCol+nC+1 Say " "
      @ nLin+nL,nCol+nC+5 Say " "
      nC:=If(nC<60,nC+4,0)
   Case nTecla=19              &&---------------> [<--]
      @ nLin+nL,nCol+nC+1 Say " "
      @ nLin+nL,nCol+nC+5 Say " "
      nC:=If(nC>0,nC-4,60)
   Case nTecla=5               &&---------------> [acima]
      @ nLin+nL,nCol+nC+1 Say " "
      @ nLin+nL,nCol+nC+5 Say " "
      nL:=If(nL>1,nL-1,16)
   Case nTecla=24              &&---------------> [abaixo]
      @ nLin+nL,nCol+nC+1 Say " "
      @ nLin+nL,nCol+nC+5 Say " "
      nL:=If(nL<16,nL+1,1)
   Case nTecla=13              &&---------------> [Enter]
      SetColor(cCor)
      RESTSCREEN(nLin,nCol,nLin+18,nCol+67,cTela)
      SetCursor(nCursor)
      SetPos(nSL,nSC)
      nAtr:=Int(((nL-1)*16)+(nC/4))
      Return (nAtr)
   Case nTecla=27              &&---------------> [Esc]
      SetColor(cCor)
      RESTSCREEN(nLin,nCol,nLin+18,nCol+67,cTela)
      SetCursor(nCursor)
      SetPos(nSL,nSC)
      Return (nAtr)
   EndCase
EndDo
Return NIL
