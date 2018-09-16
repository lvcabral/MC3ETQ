*************************************************
* NOME.....: !ATAN.PRG                          *
* FUNCAO...: ATAN()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: ATAN(< expr num>)                  *
* DESCRI€AO: RETORNA O ANGULO DE UMA TANGENTE   *
*************************************************
FUNCTION ATAN
PARAMETER TAN
PRIVATE SINAL,SOMA,TERMOS,DECREM,SN
DECREM=0
IF TAN > 1 .OR. TAN < -1
   DECREM=PI()/2
   TAN=1/TAN
ENDIF
SN=IF(TAN<0,-1,1)
TAN=ABS(TAN)
SOMA=0
SINAL=-1
FOR TERMOS = 1 TO 100 STEP 2
    SINAL=SINAL*(-1)
    SOMA=SOMA+((TAN^TERMOS)/TERMOS)*SINAL
NEXT
SOMA=ABS(DECREM-SOMA)*SN
RETURN (SOMA)
