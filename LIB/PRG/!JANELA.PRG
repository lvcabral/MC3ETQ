*************************************************
* NOME.....: !JANELA.PRG                        *
* FUNCAO...: JANELA()                           *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: JANELA()                           *
* DESCRI€AO: DESENHA UMA JANELA NA TELA.        *
*************************************************

FUNC JANELA

PARAMETERS L1,C1,L2,C2,TIPO

IF TIPO==NIL .OR. TIPO==0
   PRIVATE JANELA:=CHR(219)+CHR(223)+CHR(219)+CHR(219)+CHR(219)+CHR(220)+CHR(219)+CHR(219)
   @ L1,C1,L2,C2 BOX JANELA
ELSEIF TIPO==1
   PRIVATE COR:=SETCOLOR()
   setcolor("N+/W")
   @ l1,c1 clear to l2,c2
   @ l1,c1 to l2,c2
   Cor_tela(l1,c1,l1,c2-1,"W+/W")
   Cor_tela(l1,c1,l2,c1,"W+/W")
   setcolor(cor)
ELSEIF TIPO==2
   PRIVATE COR:=SETCOLOR()
   setcolor("W+/W")
   @ l1,c1 clear to l2,c2
   @ l1,c1 to l2,c2
   Cor_tela(l1,c1,l1,c2-1,"N+/W")
   Cor_tela(l1,c1,l2,c1,"N+/W")
   setcolor(cor)
ENDIF   
RETURN (.T.)
*******************************
