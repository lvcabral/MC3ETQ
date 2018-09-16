*************************************************
* NOME.....: !inskey.prg                        *
* FUN€ŽO...: inskey()                           *
* AUTOR....: Marcelo Leal Limaverde Cabral      *
* SINTAXE..: inskey(< expr l¢gica>)             *
* DESCRI€ŽO: Liga o modo sens¡vel … tecla INS   *
*************************************************

FUNC INSKEY

PARAMETER VAR1

IF VAR1
 SET KEY 22 TO LIGA_INS
 IF READINSERT()
   SETCURSOR(3)
 ENDIF
ELSE
 SET KEY 22 TO
ENDIF

RETURN ("")

*******************************
      PROCEDURE LIGA_INS
*******************************

IF SETCURSOR()=0
  RETURN
ELSE
  IF ! READINSERT()
   READINSERT(.T.)
   SETCURSOR(3)
  ELSE
   READINSERT(.F.)
   SETCURSOR(1)
  ENDIF
ENDIF
RETURN
