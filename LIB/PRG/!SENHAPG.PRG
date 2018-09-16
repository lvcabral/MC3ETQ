Function SenhaPrograph()
LOCAL cRet
cRet:=StrZero(Month(Date()),2)
cRet+=StrZero(Day(Date()),2)
cRet+="PG"
Return (Krypto(cRet))
