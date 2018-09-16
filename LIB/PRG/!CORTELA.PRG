/***
*  Cor_Tela( <nTop>, <nLeft>, <nBottom>, <nRight>, <cColor>) --> NIL
*  Draw a box with see through
*
*/
FUNCTION Cor_Tela( nTop, nLeft, nBottom, nRight, cColor )
   LOCAL nTotChar
   
   
   nBottom:= MIN(nBottom, MAXROW())
   nRight := MIN(nRight, MAXCOL())

   nTotChar:=( nRight - nLeft + 1 ) * ( nShadBottom - nShadTop + 1 ) 

   RESTSCREEN( nTop, nLeft, nBottom, nRight,;
       TRANSFORM( SAVESCREEN(nTop, nLeft, nBottom, nRight),;
       REPLICATE("X"+chr(AtrCor(cColor)), nTotChar ) ) )

   RETURN NIL
