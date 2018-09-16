**************
function mouse
**************
param ax,num1,num2,num3
private m_ax,m_bx,m_cx,m_dx
m_ax=strzero(ax,6)
do case
case ax=0.or.; &&-----------> Inicializa Mouse e Retorna No. de Botoes
     ax=1.or.; &&-----------> Mostra Cursor
     ax=2.or.; &&-----------> Esconde Cursor
     ax=3      &&-----------> Obtem a localizacao e os botoes pressionados
   m_bx="0000"
   m_cx="0000"
   m_dx="0000"
case ax=4      &&-----------> Muda a Posicao do Cursor
   m_bx="0000"
   do case
   case modograf()=0.or.modograf()=1
      m_cx=HL(0,num2*16)
      m_dx=HL(0,num1*8)
   case modograf()=2.or.modograf()=3
      m_cx=HL(0,num2*8)
      m_dx=HL(0,num1*8)
   case modograf()=4.or.modograf()=5.or.modograf()=13.or.modograf()=19
      m_cx=HL(0,num2*2)
      m_dx=HL(0,num1)
   other
      m_cx=HL(0,num2)
      m_dx=HL(0,num1)
   endcase
case ax=5.or.; &&-----------> Obtem status de botoes apertados
     ax=6      &&-----------> Obtem status de botoes soltos
   m_bx=strzero(num1,6)
   m_cx="0000"
   m_dx="0000"
case ax=7.or.; &&-----------> Define Colunas Minima e Maxima
     ax=8      &&-----------> Define linhas Minima e Maxima
   m_bx="0000"
   do case
   case modograf()=0.or.modograf()=1
      m_cx=HL(0,num1*16)
      m_dx=HL(0,num2*8)
   case modograf()=2.or.modograf()=3
      m_cx=HL(0,num1*8)
      m_dx=HL(0,num2*8)
   case modograf()=4.or.modograf()=5.or.modograf()=13.or.modograf()=19
      m_cx=HL(0,num1*2)
      m_dx=HL(0,num2)
   other
      m_cx=HL(0,num1)
      m_dx=HL(0,num2)
   endcase
case ax=9.or.; &&-----------> Define novo cursor para telas graficas
     ax=10     &&-----------> Define novo cursor para tela de textos
   m_bx=strzero(num1,6)
   m_cx=strzero(num2,6)
   m_dx=strzero(num3,6)
endcase   
*---------------------------------*
intbios(51,@m_ax,@m_bx,@m_cx,@m_dx)
*---------------------------------*
do case
case ax=0
   num1=val(m_bx)
case ax=3
  do case
  case modograf()=0.or.modograf()=1
     num1=VAL(m_dx)/8
     num2=VAL(m_cx)/16
  case modograf()=2.or.modograf()=3
     num1=VAL(m_dx)/8
     num2=VAL(m_cx)/8
  case modograf()=4.or.modograf()=5.or.modograf()=13.or.modograf()=19
     num1=VAL(m_dx)
     num2=VAL(m_cx)/2
  other
     num1=VAL(m_dx)
     num2=VAL(m_cx)
  endcase
  num3=VAL(m_bx)
case ax=5.or.ax=6
  ax=val(m_ax)
  num1=val(m_bx)
  do case
  case modograf()=0.or.modograf()=1
     num2=VAL(m_dx)/8
     num3=VAL(m_cx)/16
  case modograf()=2.or.modograf()=3
     num2=VAL(m_dx)/8
     num3=VAL(m_cx)/8
  case modograf()=4.or.modograf()=5.or.modograf()=13.or.modograf()=19
     num2=VAL(m_dx)
     num3=VAL(m_cx)/2
  other
     num2=VAL(m_dx)
     num3=VAL(m_cx)
  endcase
endcase
return(.t.)
