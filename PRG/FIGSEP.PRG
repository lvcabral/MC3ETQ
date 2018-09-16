****************************************************************************
**  Programa.........: FIGSEP v1.2  (C) Copyright 1991,1992               **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87                                  **
**  Descri‡„o........: Programa Separador de Figuras de Arquivos .FIG     **
**  Data de Cria‡„o..: 21/12/91  Ultima Altera‡„o..: 21/04/92             **
****************************************************************************
PARAMETERS ARQ1,ARQ2,ARQ3
?   "The Pictures Separator Program - FIGSEP v1.2"
MSG="Copyright (c) MC3 Inform tica 1991,1992. All rights Reserved."
IF CHECKSUM(SUBSTR(MSG,15,15))#1423
   ? "Erro: C¢pia n„o autorizada !"
   ?
   QUIT
ENDIF
? MSG
?
SETCANCEL(.F.)
IF TYPE("ARQ1")="U"
   ACCEPT"Arquivo Origem [.FIG]: " to ARQ1
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
   ACCEPT"Arquivo Destino 1 ...: " to ARQ2
ENDIF
ARQ2=UPPER(ALLTRIM(ARQ2))
NUM2=FCREATE(ARQ2,0)
IF FERROR()#0
   ?
   ? "Erro: Na cria‡„o do arquivo destino 1 !! codigo n§ "+strzero(ferror(),2)
   ?
   FCLOSE(NUM1)
   QUIT
ENDIF 
IF TYPE("ARQ3")="U"
   ACCEPT"Arquivo Destino 2 ...: " to ARQ3
ENDIF
ARQ3=UPPER(ALLTRIM(ARQ3))
NUM3=FCREATE(ARQ3,0)
IF FERROR()#0
   ?
   ? "Erro: Na cria‡„o do arquivo destino 2 !! codigo n§ "+strzero(ferror(),2)
   ?
   FCLOSE(NUM1)
   FCLOSE(NUM2)
   QUIT
ENDIF 
TAM1=FSEEK(NUM1,0,2)
     FSEEK(NUM1,0)
NFIG=9999
DO WHILE NFIG > (TAM1/572)
   ? 
   INPUT "Quantas figuras serao separadas ? (0 - intervalo): " to nfig
ENDDO
IF NFIG <= 0
   ?
   INPUT "N£mero inicial: " to inic
   INPUT "N£mero final..: " to fina
   NFIG=(FINA-INIC+1)
   DECLARE FIGDEL[NFIG]
   FOR T = 0 TO NFIG-1
       FIGDEL[T+1]=INIC+T
   NEXT
ELSE       
   DECLARE FIGDEL[NFIG]
   FOR T = 1 TO NFIG
       ?
       INPUT "Figura n§ "+alltrim(str(t))+": " to figdel[t]
   NEXT
ENDIF
?
LIN=ROW()
STORE 0 TO FIG,FIG1,FIG2
VEZES=INT(TAM1/572)
FOR T = 1 TO VEZES 
   FIG=FIG+1
   @ LIN  ,0 SAY "Separando ......."+ALLTRIM(STR(FIG))
   BUF2=SPACE(572)
   FREAD(NUM1,@BUF2,572)
   IF ASCAN(FIGDEL,T) = 0
      FWRITE(NUM3,BUF2)
      FIG2=FIG2+1
   ELSE
      FWRITE(NUM2,BUF2)
      FIG1=FIG1+1
   ENDIF
NEXT
FCLOSE(NUM1)
FCLOSE(NUM2)
? "Arquivo 1 [ "+arq2+" ]: "+alltrim(str(fig1))+" Figuras."
? "Arquivo 2 [ "+arq3+" ]: "+alltrim(str(fig2))+" Figuras."
?
? "Separa‡„o Realizada com Sucesso !!"
?
QUIT
*************************** >>> FIM DO PROGRAMA <<< **************************