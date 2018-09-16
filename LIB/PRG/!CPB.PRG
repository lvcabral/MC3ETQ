***************************************************
* NOME.....: !CPB.PRG                             *
* FUN€ŽO...: CPB()                                *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL        *
* SINTAXE..: CPB(x1,y1,x2,y2)                     *
* DESCRI€ŽO: APAGA PARTE DA TELA DE CIMA P/ BAIXO *
***************************************************

FUNC CPB

PARAMETERS XA,YA,XB,YB

PRIVATE CLIG,XX,T

CLIG=SETCURSOR()
SETCURSOR(0)

FOR XX = XA TO XB
 @ XA,YA CLEAR TO XX,YB
 FOR T = 1  TO  25
  @ XX,YA       TO XX,YB
 NEXT 
NEXT
@ XX-1,YA CLEAR TO XX-1,YB

SETCURSOR(CLIG)

RETURN ("")

*******************************
