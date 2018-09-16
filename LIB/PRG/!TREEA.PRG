#include "prograph.ch"
/*Function Main()
Cls
Janela(0,0,21,31)
AChoice(1,1,20,30,TreeAsArray(DirStructure("C:")))
Return NIL
*/
Function TreeAsArray( aDirStr )
Local nIdx,aTree:={},cLast,cNiv,aNivel,nOld
If Len(aDirStr)<2
   Return(aDirStr)
Endif
aNivel=Array(30)
aFill(aNivel,"")
aAdd(aTree,aDirStr[1])
aNivel[1]:=aDirStr[1]
cLast:=aDirStr[2]
For nIdx = 3 to Len(aDirStr)
   nNiv:=StrCount("\",cLast)+1
   nOld:=nNiv-1
   If cLast$aDirStr[nIdx].or.nNiv==(StrCount("\",aDirStr[nIdx])+1)
      cDir:=StrTran(cLast,aNivel[nOld]+If(nOld>1,"\",""),Indt(aNivel,cLast,aDirStr[nIdx])+"ÃÄ")
   Else
      cDir:=StrTran(cLast,aNivel[nOld]+If(nOld>1,"\",""),Indt(aNivel,cLast,aDirStr[nIdx])+"ÀÄ")
   Endif
   aAdd(aTree,cDir)
   aNivel[nNiv]:=cLast
   cLast:=aDirStr[nIdx]
Next
nNiv:=StrCount("\",cLast)+1
cDir:=StrTran(cLast,aNivel[nNiv-1],Indt(aNivel,cLast,"")+"ÀÄ")
aAdd(aTree,cDir)
Return (aTree)

Static Function Indt(aNivel,cLast,cCurrent)
Local nN,cInd:=""
nNivL:=StrCount("\",cLast)+1
nNivC:=StrCount("\",cCurrent)+1
For nN = 2 to (nNivL-1)
   If aNivel[nN]$cLast
      cInd+="³"
   Else
      cInd+=" "
   Endif
   cInd+=" "
Next
Return (cInd)
