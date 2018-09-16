*************************
Function DeKrip( cSenha )
*************************
cSenha=RIGHT(cSenha,3)+LEFT(cSenha,9)
K=""
FOR T = 1 TO 11 STEP 2
    K=K+STR(HX2DC(SUBSTR(cSenha,T,2)),3)
NEXT
S=""
S=S+CHR(VAL(SUBSTR(K,01,3))-2)
S=S+CHR(VAL(SUBSTR(K,04,3))-1)
S=S+CHR(VAL(SUBSTR(K,07,3))  )
S=S+CHR(VAL(SUBSTR(K,10,3))+2)
S=S+CHR(VAL(SUBSTR(K,13,3))-3)
S=S+CHR(VAL(SUBSTR(K,16,3))+7)

Return(S)