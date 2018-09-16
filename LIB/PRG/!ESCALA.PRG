#include "set.ch"
**********************************************
Function Escala(L,C,ATUAL,TOTAL,MSG,COR1,COR2)
**********************************************
LOCAL OLDCOR,OLDCURS,PERC,LPrint,LDevice
If Type("COR1")#"C"
   COR1=SetColor()
Endif
If Type("COR2")#"C"
   COR2=SetColor()
Endif
OLDCOR=SetColor()
OLDCURS=SetCursor()
LPrint=Set(_SET_PRINTER)
LDevice=Set(_SET_DEVICE)
SetCursor(0)
Set Print (.F.)
Set Device to SCREEN
If TOTAL>0
   PERC=Min((ATUAL*100)/TOTAL,100)
Else
   PERC=0
Endif
If PERC=0
   SetColor(COR1)
   @ L,C CLEAR TO L+4,C+28
   @ L,C TO L+4,C+28
   SetColor(COR2)
   @ L+2,C+2 SAY REPL(CHR(177),25)
Else
   SetColor(COR2)
   @ L+2,C+2 SAY REPL(CHR(219),ROUND(PERC/4,0))
Endif
SetColor(COR1)
@ L+1,C+CENTRA(MSG,29) SAY MSG
@ L+3,C+13 SAY STR(ROUND(PERC,0),3)+"%"
SetCursor(OLDCURS)
Set Print  (LPrint)
SetColor(OLDCOR)
Set(_SET_DEVICE,LDevice)
Return(.T.)
