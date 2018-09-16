*************************
Function FileTime( cArq )
*************************
private m_ax,m_bx,m_cx,m_dx,nArq,nTime,nHor,nMin,nSeg
nArq:=FOpen(cArq)
If FError() != 0
   Return("")
Endif
m_ax=HL(87,0)
m_bx=StrZero(nArq,6)
m_cx=StrZero(0,6)
m_dx=StrZero(0,6)
*---------------------------------*
intbios(33,@m_ax,@m_bx,@m_cx,@m_dx)
*---------------------------------*
FClose(nArq)

nTime:=Val(m_cx)
If nTime<0
   nTime:=65536+nTime
EndIf
nHor:=Int(nTime/2048)
nMin:=Int((nTime%2048)/32)
nSeg:=Int((nTime%2048)%32)*2
Return ( StrZero(nHor,2)+":"+StrZero(nMin,2)+":"+StrZero(nSeg,2) )

