*************************
Function Kripto( cSenha )
*************************
S=""
S=S+STR(ASC(SUBSTR(cSenha,1,1))+2,3)
S=S+STR(ASC(SUBSTR(cSenha,2,1))+1,3)
S=S+STR(ASC(SUBSTR(cSenha,3,1))  ,3)
S=S+STR(ASC(SUBSTR(cSenha,4,1))-2,3)
S=S+STR(ASC(SUBSTR(cSenha,5,1))+3,3)
S=S+STR(ASC(SUBSTR(cSenha,6,1))-7,3)
K=""
For T = 1 to 16 Step 3
    K=K+DC2HX(VAL(SubStr(S,T,3)))
NEXT
Return(RIGHT(K,9)+LEFT(K,3))
