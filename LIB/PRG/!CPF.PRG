*************************************************
* NOME.....: !CPF.PRG                           *
* FUNCAO...: CPF()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: CPF(<expr carac>)                  *
* DESCRI€AO: RETORNA .t. SE FOR UM CPF VALIDO   *
*************************************************

FUNC CPF

PARAMETER CPF

PRIVA T,D,DF1,DF2,DF3,DF4,DF5,DF6,DIG1,DIG2,RESTO,VERIFICA

************ 1§ DIGITO *************
FOR T = 1 TO 3
    D='0'+STR(T,1)
    D1&D=VAL(SUBSTR(CPF,T,1))
NEXT
FOR T = 5 TO 7
    D='0'+STR(T-1,1)
    D1&D=VAL(SUBSTR(CPF,T,1))
NEXT
FOR T = 9 TO 11
    D='0'+STR(T-2,1)
    D1&D=VAL(SUBSTR(CPF,T,1))
NEXT
DF1=10*D101+9*D102+8*D103+7*D104+6*D105+5*D106+4*D107+3*D108+2*D109
DF2=DF1/11
DF3=INT(DF2)*11
RESTO=DF1-DF3
IF RESTO=0 .OR. RESTO=1
   DIG1=0
ELSE
   DIG1=11-RESTO
ENDIF

************ 2§ DIGITO *************
DF1=11*D101+10*D102+9*D103+8*D104+7*D105+6*D106+5*D107+4*D108+3*D109+2*DIG1
DF2=DF1/11
DF3=INT(DF2)*11
RESTO=DF1-DF3
IF RESTO=0 .OR. RESTO=1
   DIG2=0
ELSE
   DIG2=11-RESTO
ENDIF

VERIFICA=STR(DIG1,1)+STR(DIG2,1)
IF VERIFICA==RIGHT(CPF,2)
   RETURN(.T.)
ELSE
   RETURN(.F.)
ENDIF
*******************************
