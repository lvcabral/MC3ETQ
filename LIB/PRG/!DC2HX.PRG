**************************************************
* NOME.....: !DC2HX.PRG                          *
* FUNCAO...: DC2HX()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL       *
* SINTAXE..: DC2HX(<expr num>)                   *
* DESCRI€AO: Transforma um valor decimal em hexa *
**************************************************

FUNC DC2HX

PARAMETER NUMERO

PRIVATE QUO,RES,DIG1,DIG2

IF TYPE("NUMERO")#"N".OR.NUMERO>255
   RETURN(0)
ENDIF

QUO=INT(NUMERO/16)
RES=NUMERO%16

DIG1=HEX_DIG(QUO)
DIG2=HEX_DIG(RES)

RETURN(DIG1+DIG2)

*************************
*SUB-FUNCAO DE CONVERSAO*
*************************
FUNC HEX_DIG
PARAM DIGITO
DO CASE
CASE DIGITO=10
     RETURN("A")
CASE DIGITO=11
     RETURN("B")     
CASE DIGITO=12
     RETURN("C")
CASE DIGITO=13
     RETURN("D")     
CASE DIGITO=14
     RETURN("E")
CASE DIGITO=15
     RETURN("F")
OTHERWISE
     RETURN(STR(DIGITO,1))
ENDCASE
*******************************