****************************************************************************
**  Programa.........: SHP2FIG v1.2 (C) Copyright 1991,1992               **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87                                  **
**  Descri‡„o........: Programa Conversor de Arquivos .SHP para .FIG      **
**  Data de Cria‡„o..: 15/11/91  Ultima Altera‡„o..: 21/04/92             **
****************************************************************************
PARAMETERS ARQ1,ARQ2
?   "Conversor de Arquivos PrintMaster/NewsMaster - SHP2FIG v1.2"
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
   ACCEPT"Arquivo Origem  [.SHP] : " to ARQ1
ENDIF   
ARQ1=UPPER(ALLTRIM(ARQ1))
IF EMPTY(FILEEXT(ARQ1))
   ARQ1=ARQ1+".SHP"
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
   ACCEPT"Arquivo Destino [.FIG] : " to ARQ2
ENDIF
ARQ2=UPPER(ALLTRIM(ARQ2))
IF EMPTY(FILEEXT(ARQ2))
   ARQ2=ARQ2+".FIG"
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
LIN=ROW()
@ LIN  ,0 SAY "Convertendo [ "+ARQ1+" -> "+ARQ2+" ]....."
FIG=0
BUF1=SPACE(2)
STAT=FREAD(NUM1,@BUF1,2)
TAMB=ASC(LEFT(BUF1,1))*ASC(RIGHT(BUF1,1))
DO WHILE STAT > 0
   FSEEK(NUM1,2,1)
   DO CASE
   CASE TAMB = 572
      BUF2=SPACE(572)
      FREAD(NUM1,@BUF2,572)
      FWRITE(NUM2,BUF2)
      FSEEK(NUM1,1,1)
   CASE TAMB < 572
      IF LEFT(BUF1,1)=CHR(03)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(3)
             FREAD(NUM1,@BUF2,3)
             FWRITE(NUM2,REPL(CHR(0),4)+BUF2+REPL(CHR(0),4))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(04)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(4)
             FREAD(NUM1,@BUF2,4)
             FWRITE(NUM2,REPL(CHR(0),4)+BUF2+REPL(CHR(0),3))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(05)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(5)
             FREAD(NUM1,@BUF2,5)
             FWRITE(NUM2,REPL(CHR(0),3)+BUF2+REPL(CHR(0),3))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(06)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(6)
             FREAD(NUM1,@BUF2,6)
             FWRITE(NUM2,REPL(CHR(0),3)+BUF2+REPL(CHR(0),2))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(07)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(7)
             FREAD(NUM1,@BUF2,7)
             FWRITE(NUM2,REPL(CHR(0),2)+BUF2+REPL(CHR(0),2))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(08)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(8)
             FREAD(NUM1,@BUF2,8)
             FWRITE(NUM2,REPL(CHR(0),2)+BUF2+CHR(0))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(09)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(9)
             FREAD(NUM1,@BUF2,9)
             FWRITE(NUM2,CHR(0)+BUF2+CHR(0))
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSEIF LEFT(BUF1,1)=CHR(10)
         NLIN=ASC(RIGHT(BUF1,1))
         NLIN=IF(NLIN<52,NLIN,52)
         FOR T = 1 TO NLIN
             BUF2=SPACE(10)
             FREAD(NUM1,@BUF2,10)
             FWRITE(NUM2,CHR(0)+BUF2)
         NEXT
         IF NLIN<52
            FWRITE(NUM2,REPL(CHR(0),11*(52-NLIN)))
         ENDIF
         FSEEK(NUM1,1,1)
      ELSE
         BUF2=SPACE(TAMB)
         FREAD(NUM1,@BUF2,TAMB)
         FWRITE(NUM2,BUF2)
         FWRITE(NUM2,REPL(CHR(0),572-TAMB))
         FSEEK(NUM1,1,1)
      ENDIF
   CASE TAMB > 572
      BUF2=SPACE(572)
      FREAD(NUM1,@BUF2,TAMB)
      FWRITE(NUM2,BUF2)
      FSEEK(NUM1,TAMB-571,1)
   ENDCASE
   STAT=FREAD(NUM1,@BUF1,2)
   TAMB=ASC(LEFT(BUF1,1))*ASC(RIGHT(BUF1,1))
   FIG=FIG+1
   @ LIN  ,0 SAY "Convertendo [ "+ARQ1+" -> "+ARQ2+" ]....."+ALLTRIM(STR(FIG))
ENDDO
FCLOSE(NUM1)
FCLOSE(NUM2)
? 
? "Convers„o Realizada com Sucesso !!"
?
QUIT
*************************** >>> FIM DO PROGRAMA <<< **************************