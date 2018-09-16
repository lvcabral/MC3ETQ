**********************************************************
* NOME.....: !TAN.PRG                                    *
* FUNCAO...: TAN()                                       *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: TAN(< expr num>)                            *
* DESCRI€AO: RETORNA A TANGENTE DE UM ANGULO EM RADIANOS *
**********************************************************
FUNCTION TAN
PARAMETER ANG
PRIVATE N,FAT,SINALC,SINALS,TERMOS,SEN,COS
STORE  1 TO FAT,TERMOS,SINALC,COS
STORE -1 TO SEN,SINALS
N=0
FOR TERMOS = 1 TO 17
    N=N+2
    FAT=FAT*N*(N-1)
    SINALS=SINALS*(-1)
    SINALC=SINALC*(-1)
    SEN=SEN+((ANG+pi()/2)^N/FAT)*SINALS
    COS=COS+(ANG^N/FAT)*SINALC
NEXT
RETURN IF(COS#0,SEN/COS,10^360)
