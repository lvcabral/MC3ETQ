#define MEIO Round((nL2-nL1)/2,0)
STATIC aBarra
*********************************
Function PList( nL1,nC1,nL2,nC2 )
*********************************
Local cTela, nImp, aTipoImp
cTela:=SaveScreen(nL1,nC1,nL2+1,nC2+1)
Explode( nL1,nC1,nL2,nC2,3 )
BoxShadow( nL1,nC1,nL2,nC2 )
aBarra:=ScrollBarNew( nL1+1,nC2-1,nL2-1,SetColor(),1 )
aTipoImp:={}
ScrollBarDisplay(aBarra)
For nImp = 1 to 99
   aAdd( aTipoImp, If(PSelect()==nImp," û ","   ")+PName(nImp) )
Next
ScrollBarUpdate( aBarra,PSelect(),99,.t.)
nImp:=AChoice(nL1+1,nC1+1,nL2-1,nC2-2,aTipoImp,.t.,"__PList",PSelect(),MEIO)
RestScreen(nL1,nC1,nL2+1,nC2+1,cTela)
Return If(nImp==0,PSelect(),nImp)
*************************************
Function __PList( nModo, nIdx, nPos )
*************************************
Do Case
Case nModo=0
   ScrollBarUpdate( aBarra,nIdx,99,.t.)
Case LastKey()=27
   Return(0)
Case LastKey()=13
   Return(1)
EndCase
Return(2)

