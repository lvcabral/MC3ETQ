Function CorAtr(nAtr)
LOCAL cCor
Do Case
Case IsBit(Chr(nAtr),0).and.IsBit(Chr(nAtr),1).and.IsBit(Chr(nAtr),2)
   cCor:="W"
Case IsBit(Chr(nAtr),0).and.IsBit(Chr(nAtr),1)
   cCor:="BG"
Case IsBit(Chr(nAtr),0).and.IsBit(Chr(nAtr),2)
   cCor:="RB"
Case IsBit(Chr(nAtr),1).and.IsBit(Chr(nAtr),2)
   cCor:="GR"
Case IsBit(Chr(nAtr),0)
   cCor:="B"
Case IsBit(Chr(nAtr),1)
   cCor:="G"
Case IsBit(Chr(nAtr),2)
   cCor:="R"
Other
   cCor:="N"
EndCase
cCor+=If(IsBit(Chr(nAtr),3),"+","")
cCor+=If(IsBit(Chr(nAtr),7),"*","")
cCor+="/"
Do Case
Case IsBit(Chr(nAtr),4).and.IsBit(Chr(nAtr),5).and.IsBit(Chr(nAtr),6)
   cCor+="W"
Case IsBit(Chr(nAtr),4).and.IsBit(Chr(nAtr),5)
   cCor+="BG"
Case IsBit(Chr(nAtr),4).and.IsBit(Chr(nAtr),6)
   cCor+="RB"
Case IsBit(Chr(nAtr),5).and.IsBit(Chr(nAtr),6)
   cCor+="GR"
Case IsBit(Chr(nAtr),4)
   cCor+="B"
Case IsBit(Chr(nAtr),5)
   cCor+="G"
Case IsBit(Chr(nAtr),6)
   cCor+="R"
Other
   cCor+="N"
EndCase
Return(cCor)
