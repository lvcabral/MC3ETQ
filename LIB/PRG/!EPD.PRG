*****************************************************
* NOME.....: !EPD.PRG                               *
* FUN€ŽO...: EPD()                                  *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL          *
* SINTAXE..: EPD(x1,y1,x2,y2)                       *
* DESCRI€ŽO: APAGA PARTE DA TELA DA ESQ. P/ DIREITA *
*****************************************************

FUNC EPD

PARAMETERS XA,YA,XB,YB

PRIVATE CLIG,YY,T

CLIG=SETCURSOR()
SETCURSOR(0)

FOR YY = YA TO YB
 @ XA,YA CLEAR TO XB,YY
 FOR T = 1  TO  6
  @ XA,YY       TO XB,YY
 NEXT 
NEXT
@ XA,YY-1 CLEAR TO XA,YY-1

SETCURSOR(CLIG)

RETURN ("")

*******************************