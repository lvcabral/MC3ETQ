*************************************************
* NOME.....: !CAPS.PRG                          *
* FUNCAO...: CAPSLOCK()                         *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: CAPSLOCK()                         *
* DESCRI€AO: RETORNA .T. OU .F. P/ TECLA CAPS.  *
*************************************************

FUNC CAPSLOCK

PL=LEFT(DC2HX(TECLAESP()),1)
IF (PL>"3".AND.PL<"8").OR.(PL>"B")
   RETURN (.T.)
ELSE
   RETURN (.F.)
ENDIF
*******************************