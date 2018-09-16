func Bissexto
param dDate
if type("dDate")#"D"
   dDate=DATE()
endif
priva nYear
nYear=YEAR(dDate)
RETURN ((nYear % 4) == 0).AND.(((nYear % 100) != 0) .OR. ((nYear % 400) == 0))
