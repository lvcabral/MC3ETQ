*************************
Function FileDate( cArq )
*************************
private m_ax,m_bx,m_cx,m_dx,nArq,nData,nAno,nMes,nDia
nArq:=FOpen(cArq)
If FError() != 0
   Return(CtoD(Space(8)))
Endif
m_ax=HL(87,0)
m_bx=StrZero(nArq,6)
m_cx=StrZero(0,6)
m_dx=StrZero(0,6)
*---------------------------------*
intbios(33,@m_ax,@m_bx,@m_cx,@m_dx)
*---------------------------------*
FClose(nArq)

nData:=Val(m_dx)
nAno:=Int(nData/512)
nMes:=Int((nData%512)/32)
nDia:=Int((nData%512)%32)
Return (CtoD( StrZero(nDia,2)+"/"+StrZero(nMes,2)+"/"+StrZero(nAno+1980,4)))

