************************************************************************
* PROGRAMA  : PM2ET.PRG                                                *
* DESCRI€AO : Converte um arquivo Print Master para o prog. Etiquetas. *
* AUTOR     : Marcelo Leal Limaverde Cabral                            *
* DATA      : 13/06/91                                                 * 
************************************************************************
PARAMETERS ARQ1,ARQ2
?"The Print Master Files Converter - PM2ET v1.0 "
?"Copyright (c) MC3 Inform tica 1991. All rights Reserved."
?
IF TYPE("ARQ1")="U"
   ACCEPT"Arquivo Origem  : " to ARQ1
ENDIF   
IF TYPE("ARQ2")="U"
   ACCEPT"Arquivo Destino : " to ARQ2
ENDIF

NUM1=FOPEN(ARQ1,0)
IF FERROR()#0
   ?
   ? "ERRO NA ABERTURA DO ARQUIVO ORIGEM !! CODIGO N§ "+STRZERO(FERROR(),2)
   ?
   QUIT
ENDIF   

NUM2=FCREATE(ARQ2,0)
IF FERROR()#0
   ?
   ? "ERRO NA CRIA€AO DO ARQUIVO DESTINO !! CODIGO N§ "+STRZERO(FERROR(),2)
   ?
   FCLOSE(NUM1)
   QUIT
ENDIF   

TAM1=FSEEK(NUM1,0,2)
     FSEEK(NUM1,4,0)
?
?
BYTES=577
BUFF1=SPACE(572)
LIN=ROW()
DO WHILE BYTES<=TAM1
   FREAD(NUM1,@BUFF1,572)
   FWRITE(NUM2,BUFF1)
   FSEEK(NUM1,5,1)
   BYTES=BYTES+577
   @ LIN  ,0 SAY "Convertendo .........."
ENDDO
FCLOSE(NUM1)
FCLOSE(NUM2)
?
? "Convers„o Realizada com Sucesso !!"
?
QUIT
*************************** >>> FIM DO PROGRAMA <<< **************************