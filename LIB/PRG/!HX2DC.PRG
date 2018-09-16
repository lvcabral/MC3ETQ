**************************************************
* NOME.....: !HX2DC.PRG                          *
* FUNCAO...: HX2DC()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL       *
* SINTAXE..: HX2DC(<expr car>)                   *
* DESCRI€AO: Transforma um valor hexa em decimal *
**************************************************

FUNC HX2DC

PARAMETER NUMERO

PRIVATE QUO,RES,DIG1,DIG2

IF TYPE("NUMERO")#"C";
   .OR.LEN(NUMERO)#2;
   .OR.!(LEFT(NUMERO,1)$"0123456789ABCDEF");
   .OR.!(RIGHT(NUMERO,1)$"0123456789ABCDEF")
   
   RETURN(.F.)
   
ENDIF

DIG1=DIG_HEX(LEFT(NUMERO,1))
DIG2=DIG_HEX(RIGHT(NUMERO,1))

RETURN((DIG1*16)+DIG2)

*************************
*SUB-FUNCAO DE CONVERSAO*
*************************
FUNC DIG_HEX
PARAM DIGITO
DIGITO=UPPER(DIGITO)
DO CASE
CASE DIGITO="A"
     RETURN(10)
CASE DIGITO="B"
     RETURN(11)     
CASE DIGITO="C"
     RETURN(12)
CASE DIGITO="D"
     RETURN(13)     
CASE DIGITO="E"
     RETURN(14)
CASE DIGITO="F"
     RETURN(15)
OTHERWISE
     RETURN(VAL(DIGITO))
ENDCASE
*******************************