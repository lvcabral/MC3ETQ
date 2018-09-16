****************************************************************************
**  Programa.........: FIG2SHP v1.2 (C) Copyright 1992                    **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87                                  **
**  Descri‡„o........: Programa Conversor de .FIG para .SHP[.SDR]         **
**  Data de Cria‡„o..: 15/04/92  Ultima Altera‡„o..: 21/04/92             **
****************************************************************************
PARAMETERS ARQ1,ARQ2
?   "Conversor de Arquivos .FIG em .SHP - FIG2SHP v1.2"
MSG="Copyright (c) MC3 Inform tica 1992. All rights Reserved."
IF CHECKSUM(SUBSTR(MSG,15,15))#1423
   ? "Erro: C¢pia n„o autorizada !"
   ?
   QUIT
ENDIF
? MSG
?
SETCANCEL(.F.)
IF TYPE("ARQ1")="U"
   ACCEPT"Arquivo Origem  [.FIG]: " to ARQ1
ENDIF   
ARQ1=UPPER(ALLTRIM(ARQ1))
IF EMPTY(FILEEXT(ARQ1))
   ARQ1=ARQ1+".FIG"
ENDIF
IF ! File(arq1)
   ?
   ? "Erro: Arquivo [ &arq1 ] n„o Existe"
   ?
   QUIT
ENDIF   
NUM1=FOPEN(ARQ1,0)
IF FERROR()#0
   ?
   ? "Erro: Na abertura do arquivo origem !! codigo n§ "+strzero(ferror(),2)
   ?
   QUIT
ENDIF   

IF TYPE("ARQ2")="U"
   ACCEPT"Arquivo Destino [.SHP]: " to ARQ2
ENDIF
ARQ2=UPPER(ALLTRIM(ARQ2))
IF EMPTY(FILEEXT(ARQ2))
   ARQ3=ARQ2+".SDR"
   ARQ2=ARQ2+".SHP"
ELSE
   ARQ3=FILEBASE(ARQ2)+".SDR"   
ENDIF

NUM2=FCREATE(ARQ2,0)
IF FERROR()#0
   ?
   ? "Erro: Na cria‡„o do arquivo destino !! codigo n§ "+strzero(ferror(),2)
   ?
   FCLOSE(NUM1)
   QUIT
ENDIF   

TAM1=FSEEK(NUM1,0,2)
     FSEEK(NUM1,0)
?
?
BYTES=572
BUFF1=SPACE(572)
LIN=ROW()
CTF=0
DO WHILE BYTES<=TAM1
   IF CTF > 0
      FWRITE(NUM2,CHR(0))
   ENDIF
   FWRITE(NUM2,CHR(11)+"4X"+CHR(0))
   FREAD(NUM1,@BUFF1,572)
   FWRITE(NUM2,BUFF1)
   BYTES=BYTES+572
   CTF=CTF+1
   @ LIN  ,0 SAY "Convertendo [ "+ARQ1+" -> "+ARQ2+" ]....."+ALLTRIM(STR(CTF))
ENDDO
FWRITE(NUM2,CHR(0))
FCLOSE(NUM1)
FCLOSE(NUM2)
?
SN=" "
DO WHILE ! SN$"SNsn"
   ACCEPT "Criar Arquivo .SDR ? (S/N): " TO SN
ENDDO
?
IF UPPER(SN)="S"
   NUM3=FCREATE(ARQ3,0)
   IF FERROR()#0
      ?
      ? "Erro: Na cria‡ao do arquivo [ &ARQ3 ] ! codigo n§ "+strzero(ferror(),2)
      ?
      QUIT
    ENDIF   
    ? "Gravando ..."
    ?
    FOR T=1 TO CTF
        FWRITE(NUM3,"Figura "+strzero(t,4)+REPL(CHR(0),5))
    NEXT    
    FCLOSE(NUM3)
ENDIF
? "Convers„o Realizada com Sucesso !!"
?
QUIT
*************************** >>> FIM DO PROGRAMA <<< **************************