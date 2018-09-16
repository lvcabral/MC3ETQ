******************************************
Function SetDateTime( cArq, dData, cHora )
******************************************
private m_ax,m_bx,m_cx,m_dx,nArq,nData,nHora
If PCount()==3.and.dData>=CtoD("01/01/80")
   nArq:=FOpen(cArq)
   If FError() != 0
      Return(.f.)
   Endif
Else
   Return(.f.)
Endif
m_ax=HL(87,1)
m_bx=StrZero(nArq,6)
nData:=512*(Year(dData)-1980)+32*Month(dData)+Day(dData)
nHora:=2048*Val(Left(cHora,2))
nHora+=32*Val(SubStr(cHora,4,2))
nHora+=Int(Val(Right(cHora,2))/2)
m_cx=StrZero(nHora,6)
m_dx=StrZero(nData,6)
*---------------------------------*
intbios(33,@m_ax,@m_bx,@m_cx,@m_dx)
*---------------------------------*
FClose(nArq)
Return(.t.)

