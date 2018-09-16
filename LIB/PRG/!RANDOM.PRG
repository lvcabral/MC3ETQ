***************
FUNCTION RANDOM
***************
PARAMETER DIG
PRIVATE V,A,T
A=""
FOR V=1 TO DIG
  A=A+RIGHT(STR(ASC(RIGHT(NOW(),1)),2),1)
  FOR T=1 TO 150
   inkey()
  NEXT
NEXT
RETURN VAL(A)
***************  