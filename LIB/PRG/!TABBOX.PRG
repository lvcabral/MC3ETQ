*嬪様様様様様様様様様様様様様様様様様様様様様様様様様邑
*� NOME.....: !TABBOX.PRG                             �
*� FUNCAO...: TABBox()                                �
*� AUTOR....: MARCELO LEAL LIMAVERDE CABRAL           �
*� SINTAXE..: TABBox([<nBox>,<cColor>])               �
*� DESCRI��O: Mostra a Tabela de Molduras para @ Box  �
*塒様様様様様様様様様様様様様様様様様様様様様様様様様余
#include "Box.CH"
Function TabBox( nBox, cColor )
LOCAL cCor,nCursor,cTela,nTecla,nSL,nSC
STATIC nLin:=3,nCol:=6,nAtr:=0
cCor:=SetColor()
nCursor:=SetCursor()
nSL:=Row()
nSC:=Col()
If ValType(nBox)#"N".or.nBox>8
   nBox:=1
EndIf
If ValType(cColor)=="C"
   SetColor(cColor)
Else
   SetColor("w+/b")
Endif
SetCursor(0)
cTela=SAVESCREEN(nLin,nCol,nLin+11,nCol+41)
Explode(nLin,nCol,nLin+10,nCol+40,3)
BoxShadow(nLin,nCol,nLin+10,nCol+40)
Do While .T.
   @ nLin+1,nCol+1 Clear to nLin+9,nCol+39
   @ nLin+2,nCol+4  SAY "敖陳朕   浜様融   嬪様邑   崢陳跳"
   @ nLin+3,nCol+4  SAY "� 01 �   � 02 �   � 03 �   � 04 �"
   @ nLin+4,nCol+4  SAY "青陳潰   藩様夕   塒様余   喞陳捗"
   @ nLin+6,nCol+4  SAY "桎烝炳      ������   +----+"
   @ nLin+7,nCol+4  SAY "� 05 �    06    � 07 �   | 08 |"
   @ nLin+8,nCol+4  SAY "桀樛樂      ������   +----+"
   Do Case
   Case nBox==1
      @ nLin+1,nCol+2  TO  nLin+5,nCol+11
   Case nBox==2
      @ nLin+1,nCol+11 TO  nLin+5,nCol+20
   Case nBox==3
      @ nLin+1,nCol+20 TO  nLin+5,nCol+29
   Case nBox==4
      @ nLin+1,nCol+29 TO  nLin+5,nCol+38
   Case nBox==5
      @ nLin+5,nCol+2  TO  nLin+9,nCol+11
   Case nBox==6
      @ nLin+5,nCol+11 TO  nLin+9,nCol+20
   Case nBox==7
      @ nLin+5,nCol+20 TO  nLin+9,nCol+29
   Case nBox==8
      @ nLin+5,nCol+29 TO  nLin+9,nCol+38
   EndCase
   nTecla=InKey(0)
   Do Case
   Case nTecla=4               &&---------------> [-->]
      If nBox#4.and.nBox#8
         nBox++
      ElseIf nBox==4
         nBox:=1
      Else
         nBox:=5
      EndIf
   Case nTecla=19              &&---------------> [<--]
      If nBox#1.and.nBox#5
         nBox--
      ElseIf nBox==1
         nBox:=4
      Else
         nBox:=8
      EndIf
   Case nTecla=5               &&---------------> [acima]
      If nBox>4
         nBox-=4
      Else
         nBox+=4
      EndIf
   Case nTecla=24              &&---------------> [abaixo]
      If nBox>4
         nBox-=4
      Else
         nBox+=4
      EndIf
   Case nTecla=13              &&---------------> [Enter]
      SetColor(cCor)
      RESTSCREEN(nLin,nCol,nLin+11,nCol+41,cTela)
      SetCursor(nCursor)
      SetPos(nSL,nSC)
      Do Case
      Case nBox==1
         Return (B_SINGLE)
      Case nBox==2
         Return (B_DOUBLE)
      Case nBox==3
         Return (B_SINGLE_DOUBLE)
      Case nBox==4
         Return (B_DOUBLE_SINGLE)
      Case nBox==5
         Return ("桎栩桀栩")
      Case nBox==6
         Return (Repl(Chr(4),8))
      Case nBox==7
         Return (Repl(Chr(254),8))
      Case nBox==8
         Return ("+-+|+-+|")
      EndCase
   Case nTecla=27              &&---------------> [Esc]
      SetColor(cCor)
      RESTSCREEN(nLin,nCol,nLin+11,nCol+41,cTela)
      SetCursor(nCursor)
      SetPos(nSL,nSC)
      Return ("")
   EndCase
EndDo
Return NIL

