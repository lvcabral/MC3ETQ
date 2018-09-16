*************************************************
* NOME.....: !PAUSA.PRG                         *
* FUNCAO...: PAUSA()                            *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: PAUSA()                            *
* DESCRI€AO: INTERROMPE IMPRESSAO               *
*************************************************
#include "set.ch"
FUNC PAUSA

PARAM PCOR

PRIVATE escolha,tela,cor,LPrint,LDevice,LCursor
IF INKEY()==27
 IF TYPE("PCOR")#"C"
    PCOR="W+/B,B/W"
 ENDIF
 LPrint=SET(_SET_PRINTER)
 LDevice=SET(_SET_DEVICE)
 LCursor=SETCursor()
 CLEAR TYPEAHEAD
 SET PRINT OFF
 SET DEVICE TO SCREEN
 SETCURSOR(0)
 COR=SETCOLOR()
 TELA=SAVESCREEN(8,35,14,53)
 COR_TELA(9,37,14,53,"W/N")
 SETCOLOR(PCOR)
 SCROLL(8,35,13,51,0)
 @ 8,35 TO 13,51 DOUBLE
 @ 10,36 TO 10,50
 ESCOLHA=1
 @ 9,36 SAY '###  PAUSA  ###'
 @ 11,36 PROMPT'    ABANDONA   '
 @ 12,36 PROMPT'    CONTINUA   '
 MENU TO ESCOLHA
 SETCOLOR(COR)
 RESTSCREEN(8,35,14,53,TELA)
 SET(_SET_PRINTER,LPrint)
 SETCURSOR(LCursor)
 SET(_SET_DEVICE,LDevice) 
 RETURN (IF(ESCOLHA==1,.F.,.T.))
ENDIF
RETURN .T.
