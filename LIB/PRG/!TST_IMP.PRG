*************************************************
* NOME.....: !TST_IMP.PRG                       *
* FUNCAO...: TESTA_IMP()                        *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: TESTA_IMP()                        *
* DESCRI€AO: TESTA O ESTADO DA IMPRESSORA       *
*************************************************

FUNCTION TESTA_IMP
PARAM TCOR

PRIVATE RETL
RETL=.T.
DO WHILE .NOT. ISPRINTER()
   IF NAOPRONTA(TCOR)
      RETL=.F.
      EXIT
   ENDIF
ENDDO
RETURN (RETL)

******************
FUNCTION NAOPRONTA
******************
PARAM TCOR
PRIVATE escolha,tela,cor
IF .NOT. ISPRINTER()
 IF TYPE("TCOR")#"C"
    TCOR="W+/B,B/W"
 ENDIF
 CLEAR TYPEAHEAD
 COR=SETCOLOR()
 TELA=SAVESCREEN(11,17,16,64)
 COR_TELA(12,19,16,64,"W/N")
 SETCOLOR(TCOR)
 SCROLL(11,17,15,62,0)
 @ 11,17 TO 15,62 DOUBLE
 @ 13,18 TO 13,61
 ESCOLHA=1
 @ 12,19 SAY "ATEN€AO !! Sua Impressora N„o Est  Pronta."
 @ 14,19 SAY "ESCOLHA: "
 @ 14,28 PROMPT 'TENTAR NOVAMENTE'
 @ 14,52 PROMPT 'ABANDONAR'
 MENU TO ESCOLHA
 SETCOLOR(COR)
 RESTSCREEN(11,17,16,64,TELA)
 RETURN IF(ESCOLHA==1,.F.,.T.)
ENDIF
RETURN .F.

