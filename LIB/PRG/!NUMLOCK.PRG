**************************************************
* NOME.....: !NUMLOCK.PRG                        *
* FUNCAO...: NUMLOCK()                           *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL       *
* SINTAXE..: NUMLOCK()                           *
* DESCRI€AO: RETORNA .T. OU .F. P/ TECLA NUMLOCK *
**************************************************

FUNC NUMLOCK

PL=LEFT(DC2HX(TECLAESP()),1)
IF (PL$"2367ABEF")
   RETURN (.T.)
ELSE
   RETURN (.F.)
ENDIF
*******************************