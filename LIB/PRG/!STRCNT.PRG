#define IS_NOT_LOGICAL(x)            (VALTYPE(x) != "L")
#define MAKE_UPPER(x)                (x := UPPER(x))

Function StrCount(cCheckFor, cCheckIn, lIgnoreCase)

If (IS_NOT_LOGICAL(lIgnoreCase) .OR. lIgnoreCase)
   MAKE_UPPER(cCheckFor)             //  No, Force Everything to Uppercase
   MAKE_UPPER(cCheckIn)
EndIf
Return (If(Len(cCheckFor) == 0.or.Len(cCheckIn) == 0,0,;
       INT((LEN(cCheckIn)-LEN(STRTRAN(cCheckIn,cCheckFor)))/LEN(cCheckFor))))
