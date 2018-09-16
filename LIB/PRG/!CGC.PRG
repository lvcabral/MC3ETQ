*************************************************
* NOME.....: !CGC.PRG                           *
* FUNCAO...: CGC()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: CGC(<expr carac>)                  *
* DESCRI€AO: RETORNA .t. SE FOR UM CGC VALIDO   *
*************************************************

FUNC CGC

PARAMETER CGC

PRIVATE NUM1

NUM1=SUBSTR(CGC,1,1)+SUBSTR(CGC,4,1)+SUBSTR(CGC,6,1)+SUBSTR(CGC,9,1)
NUM1=LTRIM(STR(VAL(NUM1)*2,5))
NUM1=VAL(SUBSTR(NUM1,1,1))+VAL(SUBSTR(NUM1,2,1))+VAL(SUBSTR(NUM1,3,1))+;
     VAL(SUBSTR(NUM1,4,1))+VAL(SUBSTR(NUM1,5,1))
NUM2=LTRIM(SUBSTR(CGC,2,1)+SUBSTR(CGC,5,1)+SUBSTR(CGC,8,1)+SUBSTR(CGC,10,1))
NUM2=VAL(SUBSTR(NUM2,1,1))+VAL(SUBSTR(NUM2,2,1))+VAL(SUBSTR(NUM2,3,1))+;
     VAL(SUBSTR(NUM2,4,1))
NUM3=NUM1+NUM2
IF NUM3 # INT(NUM3/10)*10
   RETURN(.F.)
ELSE
   RETURN(.T.)
ENDIF
*******************************
