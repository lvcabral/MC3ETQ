****************************************************
* NOME.....: !ACENTUA.PRG                          *
* FUN€ŽO...: ACENTUA()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL         *
* SINTAXE..: ACENTUA(< expr log>)                  *
* DESCRI€ŽO: ACENTUA EM PORTUGUES NO CLIPPER 5.2   *
*--------------------------------------------------*
*         Set Modo=1 ----> Tabela BRASCII          *
*         Set Modo=2 ----> Tabela CodePage 850     *
*         Set Modo=3 ----> Tabela CodePage 860     *
****************************************************

Function Acentua( Liga )

IF LIGA
 SET KEY 39 TO _ACENTO_ON
 SET KEY 96 TO _ACENTO_ON
 SET KEY 94 TO _ACENTO_ON
 SET KEY 126 TO _ACENTO_ON
ELSE
 SET KEY 39 TO
 SET KEY 96 TO
 SET KEY 94 TO
 SET KEY 126 TO
ENDIF

_VETOR_AC(LIGA)

RETURN(.T.)

********************
PROCEDURE _ACENTO_ON
********************

PARAM PRR,LNN,VRR

LOCAL UTC,ACE,AM,EM,IM,OM,UM,AN,ON

IF LEFT(PRR,5)='_ACEN' //.OR.SETCURSOR()=0
 RETURN
ENDIF

UTC=LASTKEY()
ACE=INKEY(0)

**************
*ACENTO AGUDO*
**************
IF UTC=39
 DO CASE
    CASE GETE("MODO")="1"
         AM=248
         IM=230
         OM=231
         UM=238
    CASE GETE("MODO")="2"
         AM=181
         IM=214
         OM=224
         UM=233
    OTHER &&   MODO = "3"
         AM=134
         IM=139
         OM=159
         UM=150
 ENDCASE
 DO CASE
    CASE CHR(ACE)='a'
        KEYB CHR(160)
    CASE CHR(ACE)='e'
        KEYB CHR(130)
    CASE CHR(ACE)='i'
        KEYB CHR(161)
    CASE CHR(ACE)='o'
        KEYB CHR(162)
    CASE CHR(ACE)='u'
        KEYB CHR(163)
    CASE CHR(ACE)='c'
        KEYB CHR(135)
    CASE CHR(ACE)='A'
         KEYB CHR(AM)
    CASE CHR(ACE)='E'
        KEYB CHR(144)
    CASE CHR(ACE)='I'
        KEYB CHR(IM)
    CASE CHR(ACE)='O'
        KEYB CHR(OM)
    CASE CHR(ACE)='U'
        KEYB CHR(UM)
    CASE CHR(ACE)='C'
        KEYB CHR(128)
    CASE CHR(ACE)="'"
        SET KEY 39 TO
        SET KEY 127 TO AC_AGAIN
        KEYB CHR(39)+CHR(127)
    OTHER
        KEYB CHR(ACE)
 ENDCASE

**************
*ACENTO CRASE*
**************

ELSEIF UTC=96
 DO CASE
    CASE GETE("MODO")="1"
         AM=235
    CASE GETE("MODO")="2"
         AM=183
    OTHER &&   MODO = "3"
         AM=145
 ENDCASE
  DO CASE
     CASE CHR(ACE)='a'
        KEYB CHR(133)
     CASE CHR(ACE)='A'
        KEYB CHR(AM)
     CASE CHR(ACE)='`'
        SET KEY 96 TO
        SET KEY 127 TO AC_AGAIN
        KEYB CHR(96)+CHR(127)
     OTHER
        KEYB CHR(ACE)
  ENDCASE

********************
*ACENTO CIRCUNFLEXO*
********************
ELSEIF UTC=94
 DO CASE
    CASE GETE("MODO")="1"
         AM=236
         EM=229
         OM=232
    CASE GETE("MODO")="2"
         AM=182
         EM=210
         OM=226
    OTHER &&   MODO = "3"
         AM=143
         EM=137
         OM=140
 ENDCASE
  DO CASE
    CASE CHR(ACE)='a'
        KEYB CHR(131)
    CASE CHR(ACE)='e'
        KEYB CHR(136)
    CASE CHR(ACE)='o'
        KEYB CHR(147)
    CASE CHR(ACE)='A'
        KEYB CHR(AM)
    CASE CHR(ACE)='E'
        KEYB CHR(EM)
    CASE CHR(ACE)='O'
        KEYB CHR(OM)
    CASE CHR(ACE)="^"
        SET KEY 94 TO
        SET KEY 127 TO AC_AGAIN
        KEYB CHR(94)+CHR(127)
    OTHER
        KEYB CHR(ACE)
  ENDCASE

************
*ACENTO TIL*
************

ELSEIF UTC=126
 DO CASE
    CASE GETE("MODO")="1"
         AM=233
         OM=239
         AN=226
         ON=249
    CASE GETE("MODO")="2"
         AM=199
         OM=229
         AN=198
         ON=228
    OTHER &&   MODO = "3"
         AM=142
         OM=153
         AN=132
         ON=148
 ENDCASE
  DO CASE
    CASE CHR(ACE)='a'
        KEYB CHR(AN)
    CASE CHR(ACE)='o'
        KEYB CHR(ON)
    CASE CHR(ACE)='u'
        KEYB CHR(129)
    CASE CHR(ACE)='n'
        KEYB CHR(164)
    CASE CHR(ACE)='A'
        KEYB CHR(AM)
    CASE CHR(ACE)='O'
        KEYB CHR(OM)
    CASE CHR(ACE)='U'
        KEYB CHR(154)
    CASE CHR(ACE)='N'
        KEYB CHR(165)
    CASE CHR(ACE)="~"
        SET KEY 126 TO
        SET KEY 127 TO AC_AGAIN
        KEYB CHR(126)+CHR(127)
    OTHER
        KEYB CHR(ACE)
 ENDCASE
ENDIF
RETURN

***************
PROCED AC_AGAIN
***************

ACENTUA(.T.)
SET KEY 127 TO
RETURN

*******************************
STATIC FUNCTION _VETOR_AC(LIGA)
*******************************
IF LIGA
   PUBLIC _ACTEL[29],_ACIMP[29],_ACNTX[29]

   DO CASE
   CASE GETENV("MODO")=="1"
     _ACTEL:={248,160,144,130,230,161,231,162,238,163,235,133,236,131,229,;
              136,232,147,233,226,239,249,128,135,165,164,154,129,255}
   CASE GETENV("MODO")=="2"
     _ACTEL:={181,160,144,130,214,161,224,162,233,163,183,133,182,131,210,;
              136,226,199,198,229,228,148,128,135,165,164,154,129,255}
   OTHER && MODO = "3"
     _ACTEL:={134,160,144,130,139,161,159,162,150,163,145,133,143,131,137,;
              136,140,147,142,132,153,148,128,135,165,164,154,129,255}
   ENDCASE

   _ACIMP:={"A"+CHR(8)+"'","a"+CHR(8)+"'","E"+CHR(8)+"'","e"+CHR(8)+"'",;
            "I"+CHR(8)+"'","i"+CHR(8)+"'","O"+CHR(8)+"'","o"+CHR(8)+"'",;
            "U"+CHR(8)+"'","u"+CHR(8)+"'","A"+CHR(8)+"`","a"+CHR(8)+"`",;
            "A"+CHR(8)+"^","a"+CHR(8)+"^","E"+CHR(8)+"^","e"+CHR(8)+"^",;
            "O"+CHR(8)+"^","o"+CHR(8)+"^","A"+CHR(8)+"~","a"+CHR(8)+"~",;
            "O"+CHR(8)+"~","o"+CHR(8)+"~","C"+CHR(8)+",","c"+CHR(8)+",",;
            "N"+CHR(8)+"~","n"+CHR(8)+"~","U","u",CHR(32)}

   _ACNTX:={"A","a","E","e","I","i","O","o","U","u","A","a","A","a","E","e",;
            "O","o","A","a","O","o","C","c","N","n","U","u"," "}
ELSE
   RELEASE _ACTEL,_ACIMP,_ACNTX
ENDIF
RETURN(NIL)
********************************
