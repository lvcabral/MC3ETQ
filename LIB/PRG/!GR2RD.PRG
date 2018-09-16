*************************************************
* NOME.....: !GR2RD.PRG                         *
* FUNCAO...: GR2RD()                            *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: GR2RD(<expr num>)                  *
* DESCRI€AO: Transf. um ang. de grau p/ radiano *
*************************************************
FUNCTION GR2RD
PARAMETER nGraus 
RETURN ((nGraus/180) * PI())
*******************************