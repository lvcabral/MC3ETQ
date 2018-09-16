*ีอออออออออออออออออออออออออออออออออออออออออออออออออธ
*ณ NOME.....: !TABASC.PRG                          ณ
*ณ FUNCAO...: TABASCII()                           ณ
*ณ AUTOR....: MARCELO LEAL LIMAVERDE CABRAL        ณ
*ณ SINTAXE..: TABASCII()                           ณ
*ณ DESCRI€O: Mostra a Tabela ASCII em uma Janela  ณ
*ิอออออออออออออออออออออออออออออออออออออออออออออออออพ
Function TabASCII()
LOCAL cCor,nCursor,nSL,nSC,cTela,nPag,cC,nC,nL,nTecla
STATIC nLin:=3,nCol:=2
cCor=SetColor("w+/b")
nCursor=SetCursor(0)
nSL=Row()
nSC=Col()
nPag:=1
Do While .T.
   cTela=SAVESCREEN(nLin,nCol,nLin+16,nCol+27)
   @ nLin,nCol Clear to nLin+15,nCol+26
   Janela(nLin,nCol,nLin+15,nCol+26)
   BoxShadow(nLin,nCol,nLin+15,nCol+26)
   cC:=If(nPag==1,0,130)
   @ nLin+1,nCol+6 Say  "0 1 2 3 4 5 6 7 8 9" Color "gr+/b"
   For nL=2 to 14
      @ nLin+nL,nCol+2 Say Str(cC,3) Color "gr+/b"
      For nC=6 to 24 Step 2
         @ nLin+nL,nCol+nC Say Chr(cC) Color "w+/b"
         cC++
         If cC==255
            Exit
         Endif
      Next
   Next
   Do While .T.
      nTecla=InKey(0)
      Do Case
      Case nTecla=4               &&---------------> [-->]
         If nCol < MaxCol()-27
            RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
            nCol++
            Exit
         EndIf
      Case nTecla=19              &&---------------> [<--]
         If nCol > 0
            RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
            nCol--
            Exit
         EndIf
      Case nTecla=5               &&---------------> [acima]
         If nLin > 0
            RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
            nLin--
            Exit
         EndIf
      Case nTecla=24              &&---------------> [abaixo]
         If nLin < MaxRow()-16
            RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
            nLin++
            Exit
         EndIf
      Case nTecla=18              &&---------------> [PgUp]
         RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
         nPag:=1
         Exit
      Case nTecla=3               &&---------------> [PgDn]
         RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
         nPag:=2
         Exit
      Case nTecla=27              &&---------------> [Esc]
         SetColor(cCor)
         SetCursor(nCursor)
         RESTSCREEN(nLin,nCol,nLin+16,nCol+27,cTela)
         SetPos(nSL,nSC)
         Return NIL
      EndCase
   EndDo
EndDo
Return NIL
