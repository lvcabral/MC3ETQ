*************************************************
* NOME.....: !SEN.PRG                           *
* FUNCAO...: SEN()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: SEN(< expr num>)                   *
* DESCRI€AO: RETORNA O SENO DE UM ANGULO EM RAD *
*************************************************
FUNCTION SEN
PARAMETER ANG
PRIVATE N,FAT,SINAL,SOMA,TERMOS
STORE 1 TO FAT,TERMOS
SOMA=-1
SINAL=-1
N=0
FOR TERMOS = 1 TO 17
    N=N+2
    FAT=FAT*N*(N-1)
    SINAL=SINAL*(-1)
    SOMA=SOMA+((ANG+pi()/2)^N/FAT)*SINAL
NEXT
RETURN (SOMA)
