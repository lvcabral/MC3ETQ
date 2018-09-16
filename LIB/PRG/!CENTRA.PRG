*************************************************
* NOME.....: !CENTRA.PRG                        *
* FUNCAO...: CENTRA()                           *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: CENTRA(<expr carac.>[,<expr num>]) *
* DESCRI€AO: CENTRALIZA UM TEXTO                *
*************************************************

FUNC CENTRA

PARAMETERS TEXTO,LARGURA

TEXTO=TRIM(TEXTO)
IF TYPE("LARGURA")="U"
 LARGURA=MAXCOL()+1
ENDIF
RETURN ((LARGURA-LEN(TEXTO))/2)

*******************************