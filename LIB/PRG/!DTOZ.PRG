*************************************************
* NOME.....: !DTOZ.PRG                          *
* FUNCAO...: DTOZ()                             *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: DTOZ(<expr data>)                  *
* DESCRI€AO: Comprime uma data para 03 bytes.   *       
*************************************************
FUNCTION DTOZ
PARAMETER dData 
RETURN (chr(VAL(RIGHT(STR(year(dData),4),2)))+chr(month(dData))+chr(day(dData)))
*************************************************