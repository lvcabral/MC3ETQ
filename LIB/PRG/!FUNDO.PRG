**************************
Function Fundo( nBH, nBL )
**************************
LOCAL m_ax,m_bx,m_cx,m_dx
m_ax=HL(11,0)
m_bx=HL(nBH,nBL)
m_cx="0000"
m_dx="0000"
*---------------------------------*
intbios(16,@m_ax,@m_bx,@m_cx,@m_dx)
*---------------------------------*
return(.t.)
