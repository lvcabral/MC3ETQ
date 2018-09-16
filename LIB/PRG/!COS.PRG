*************************************************
* NOME.....: !COS.PRG                           *
* FUNCAO...: COS()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: COS(< expr num>)                   *
* DESCRI€AO: RETORNA O COSSENO DE UM ANG.EM RAD *
*************************************************
FUNCTION COS
PARAMETER ANG
PRIVATE N,FAT,SINAL,SOMA,TERMOS
STORE 1 TO FAT,SINAL,SOMA,TERMOS
N=0
FOR TERMOS = 1 TO 17
    N=N+2
    FAT=FAT*N*(N-1)
    SINAL=SINAL*(-1)
    SOMA=SOMA+(ANG^N/FAT)*SINAL
NEXT

RETURN (SOMA)

    