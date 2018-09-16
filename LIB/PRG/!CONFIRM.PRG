*************************************************
FUNCTION CONFIRMA( TEXTO,CORNOVA,LES )

LOCAL ces,largjan,telavelha,corantig,lin,col,cursor

IF VALTYPE(LES)#"N"
   LES=INT(MAXROW()/2)-2
ENDIF
lin=ROW()
col=COL()
cursor=SETCURSOR()
SETCURSOR(0)
largjan=LEN(texto)+2
IF largjan<16
 largjan=16
ENDIF 
ces=(MAXCOL()-largjan)/2
telavelha=SAVESCREEN(les,0,les+4,MAXCOL())
corantig=SETCOLOR()
cornova=IF(VALTYPE(CORNOVA)#"C",SETCOLOR(),cornova)
SETCOLOR(CORNOVA)
@les,ces CLEAR TO les+3,ces+largjan
JANELA(les,ces,les+3,ces+largjan)
@les+1,ces+2 SAY texto
coluna=(largjan-11)/2
@les+2,ces+coluna PROMPT " Sim "
@les+2,ces+coluna+8 PROMPT " N„o "
MENU TO CONFIRM 
SETCOLOR(CORANTIG)
RESTSCREEN(les,0,les+4,MAXCOL(),telavelha)
SETPOS(lin,col)
SETCURSOR(CURSOR)
RETURN (CONFIRM=1)
*************************************************
