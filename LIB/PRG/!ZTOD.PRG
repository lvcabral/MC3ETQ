*************************************************
* NOME.....: !ZTOD.PRG                          *
* FUNCAO...: ZTOD()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: ZTOD(<expr char>)                  *
* DESCRI€AO: Descomprime uma data para 08 bytes.*       
*************************************************
FUNCTION ZTOD 
PARAMETER zData 
RETURN( ctod(strzero(asc(right(zData,1)),2)+'/'+strzero(asc(substr(zData,2,1)),2)+'/'+strzero(asc(left(zData,1)),2)) )
*************************************************