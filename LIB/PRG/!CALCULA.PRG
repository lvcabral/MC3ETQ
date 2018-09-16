*************************************************
* NOME.....: !CALCULA.PRG                       *
* FUNCAO...: CALCULA()                          *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: CALCULA(x,y,[<cor>],[<digital>])   *
* DESCRI€AO: EXPLODE UMA CALCULADORA NA TELA.   *
*************************************************
FUNCTION CALCULA( LIN,COL,CORAUX,DIG )

MEMVAR NIVHLP
LOCAL LINX,COLX,TECLA,TELA,SEM,AJU,COR,VALOR1,VALOR2,VIRG,;
      PRIM,VAUX,OPER,ERRO,OLDN,TEMP

COR =SETCOLOR()
IF Type("NIVHLP") == "N"
   OLDN=NIVHLP
ELSE
   OLDN=000
ENDIF
NIVHLP=901
ERRO=.F.
IF LIN==NIL
   LIN=1
ENDIF

IF COL==NIL
   COL=0
ENDIF

IF CORAUX#NIL
   SETCOLOR(CORAUX)
ENDIF

IF DIG==NIL
   DIG=.f.
ENDIF
ACOD1={48,49,50,51,52,53,54,55,56,57}
ACOD2={CHR(10),CHR(11),CHR(12),CHR(13),CHR(14),;
       CHR(15),CHR(16),CHR(17),CHR(18),CHR(19)}
CNORM=SETCOLOR()
CPOSI=AT(",",CNORM)+1
CFINA=AT(",",SUBSTR(CNORM,CPOSI+1))
CINVE=SUBSTR(CNORM,CPOSI,CFINA)
STORE SPACE(19)+"0" TO VALOR1,VALOR2
STORE SPACE(01)     TO OPER
VIRG=.F.
PRIM=.T.
OP=1
DO WHILE .T.
   TELA=SAVESCREEN(LIN,COL,LIN+14,COL+31)
   SETCOLOR(CNORM)
   @ LIN+00,COL SAY ' ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ '
   @ LIN+01,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+02,COL SAY ' Û±ÛßßßßßßßßßßßßßßßßßßßßßßßÛ±Û '
   @ LIN+03,COL SAY ' Û±Û                       Û±Û '
   @ LIN+04,COL SAY ' Û±ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ±Û '
   @ LIN+05,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+06,COL SAY ' Û±± 7 ± 8 ± 9 ±±±± / ±± * ±±Û '
   @ LIN+07,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+08,COL SAY ' Û±± 4 ± 5 ± 6 ±±±± + ±± - ±±Û '
   @ LIN+09,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+10,COL SAY ' Û±± 1 ± 2 ± 3 ±±±± = ±± C ±±Û '
   @ LIN+11,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+12,COL SAY ' Û±±   0   ± , ±±±±ESC±±INS±±Û '
   @ LIN+13,COL SAY ' Û±±±±±±±±±±±±±±±±±±±±±±±±±±±Û '
   @ LIN+14,COL SAY ' ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß '
   SETCOLOR(CINVE)
   DO WHILE .T.
      @ LIN+03,COL+5 SAY OPER
      IF ! DIG
         @ LIN+03,COL+6 SAY VALOR1
      ELSE
         TEMP=VALOR1
         CONVALL(ACOD1,ACOD2,@TEMP)
         @ LIN+03,COL+6 SAY TEMP
      ENDIF
      TECLA=INKEY(0)
      DO CASE
      CASE TECLA=4               &&---------------> [-->]
         IF COL < MAXCOL()-30
            RESTSCREEN(LIN,COL,LIN+14,COL+31,TELA)
            COL = COL+1
            EXIT
         ENDIF
      CASE TECLA=19              &&---------------> [<--]
         IF COL > 0
            RESTSCREEN(LIN,COL,LIN+14,COL+31,TELA)
            COL = COL-1
            EXIT
         ENDIF
      CASE TECLA=5               &&---------------> [acima]
         IF LIN > 0
            RESTSCREEN(LIN,COL,LIN+14,COL+31,TELA)
            LIN = LIN-1
            EXIT
         ENDIF
      CASE TECLA=24              &&---------------> [abaixo]
         IF LIN < MAXROW()-14
            RESTSCREEN(LIN,COL,LIN+14,COL+31,TELA)
            LIN = LIN+1
            EXIT
         ENDIF
      CASE TECLA=27.OR.TECLA=22  &&---------------> [Esc] [INS]
         SETCOLOR(COR)
         RESTSCREEN(LIN,COL,LIN+14,COL+31,TELA)
         IF TECLA=22
            KEYB ALLTRIM(VALOR1)
         ENDIF
         NIVHLP=OLDN
         RETURN(VAL(STRTRAN(VALOR1,",",".")))
      CASE TECLA=28              &&---------------> [F1]
         HELP()
      CASE TECLA=44.OR.TECLA=46  &&---------------> [.] [,]
         IF ! VIRG
            VIRG=.T.
            IF PRIM
               PRIM=.F.
               VALOR1=SPACE(18)+'0,'
            ELSE
               VALOR1=SPACE(19-LEN(ALLTRIM(VALOR1)))+ALLTRIM(VALOR1)+','
            ENDIF
         ENDIF
      CASE TECLA>47.AND.TECLA<58 &&---------------> [N§s]
         IF PRIM
           IF TECLA#48
            PRIM=.F.
            VALOR1=SPACE(19)+CHR(TECLA)
           ENDIF
         ELSE
            IF LEN(ALLTRIM(VALOR1))<20
               VALOR1=SPACE(19-LEN(ALLTRIM(VALOR1)))+ALLTRIM(VALOR1)+CHR(TECLA)
            ENDIF
         ENDIF
      CASE CHR(TECLA)$"/*-+=".OR.TECLA=13
         VIRG=.F.
         PRIM=.T.

         DO CASE
         CASE OP=0
           STORE VAL(STRTRAN(VALOR1,",",".")) TO VAUX
         CASE OP=1
           STORE VAL(STRTRAN(VALOR2,",","."))+VAL(STRTRAN(VALOR1,",",".")) TO VAUX
         CASE OP=2
           STORE VAL(STRTRAN(VALOR2,",","."))-VAL(STRTRAN(VALOR1,",",".")) TO VAUX
         CASE OP=3
           STORE VAL(STRTRAN(VALOR2,",","."))*VAL(STRTRAN(VALOR1,",",".")) TO VAUX
         CASE OP=4
           IF VAL(STRTRAN(VALOR1,",",".")) = 0
              STORE 0 TO VAUX
              ERRO=.T.
           ELSE
              STORE VAL(STRTRAN(VALOR2,",","."))/VAL(STRTRAN(VALOR1,",",".")) TO VAUX
              ERRO=.F.
           ENDIF
         ENDCASE

         DO CASE
         CASE CHR(TECLA)="=".OR.TECLA=13
           IF ERRO
              OPER='E'
              ERRO=.F.
           ELSE
              OPER='='
           ENDIF
           OP=0
         CASE CHR(TECLA)="+"
           OPER=CHR(TECLA)
           OP=1
         CASE CHR(TECLA)="-"
           OPER=CHR(TECLA)
           OP=2
         CASE CHR(TECLA)="*"
           OPER=CHR(TECLA)
           OP=3
         CASE CHR(TECLA)="/"
           OP=4
           OPER='/'
         ENDCASE

         STORE SPACE(20-LENNUM(VAUX))+LEFT(STRTRAN(LTRIM(STR(VAUX)),".",","),20);
               TO VALOR1,VALOR2
         IF AT("*",VALOR1)>0
            OPER='E'
         ENDIF
      CASE TECLA=67.OR.TECLA=99
         VIRG=.F.
         PRIM=.T.
         OP=1
         OPER=' '
         STORE SPACE(19)+"0" TO VALOR1,VALOR2
      ENDCASE
   ENDDO
ENDDO
*******************************
