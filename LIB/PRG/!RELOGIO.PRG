Static lRelogio_:=.f.
************************************************
Function Relogio( LgDg, nLin, nCol, cCor, lSeg )
************************************************
#define LIGAR      1
#define DESLIGAR   0
Static sSeg:=.t.
If VALTYPE(LgDg)#"L"
   Return(.f.)
EndIf
If VALTYPE(nLin)#"N"
   nLin=0
EndIf
If VALTYPE(nCol)#"N"
   nCol=0
EndIf
If VALTYPE(cCor)#"C"
   cCor=SetColor()
EndIf
If VALTYPE(lSeg)#"L"
   lSeg=.t.
EndIf

If At(",",cCor)>0
  cCor=Upper(Left(cCor,At(",",cCor)-1))
Else
  cCor=Upper(cCor)
EndIf

If lRelogio_.and.!LgDg
   If sSeg
      Clock1( DESLIGAR, nLin, nCol, AtrCor( cCor ) )
   Else
      Clock2( DESLIGAR, nLin, nCol, AtrCor( cCor ) )
   EndIf
   lRelogio_=.f.
ElseIf LgDg.and.!lRelogio_
   If lSeg
      Clock1( LIGAR, nLin, nCol, AtrCor( cCor ) )
   Else
      Clock2( LIGAR, nLin, nCol, AtrCor( cCor ) )
   Endif
   lRelogio_=.t.
   sSeg:=lSeg
Else
   Return(.f.)
EndIf
Return(.t.)

******************
Function IsClock()
******************
Return (lRelogio_)
