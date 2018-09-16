*************************************************
* NOME.....: !SENHA.PRG                         *
* FUNCAO...: SENHA()                            *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: SENHA(X,Y)                         *
* DESCRI€AO: RETORNA UMA SENHA DIGITADA         *
*************************************************
#include "set.ch"
Function SENHA( LIN,COL )
Local S[6],SE,K,C,T

C=SET(_SET_CONFIRM)
AFILL(S,chr(219))

SET CONFIRM OFF
For T = 0 to 5
    @ LIN,COL+T  GET S[T+1] PICTURE '!'
    READ
    @ LIN,COL+T  SAY '*'
Next
SET(_SET_CONFIRM,C)
SE=""
SE=SE+STR(ASC(S[1])+2,3)
SE=SE+STR(ASC(S[2])+1,3)
SE=SE+STR(ASC(S[3]),3)
SE=SE+STR(ASC(S[4])-2,3)
SE=SE+STR(ASC(S[5])+3,3)
SE=SE+STR(ASC(S[6])-7,3)
K=""
FOR T = 1 TO 16 STEP 3
    K=K+DC2HX(VAL(SUBSTR(SE,T,3)))
NEXT
RETURN (RIGHT(K,9)+LEFT(K,3))
