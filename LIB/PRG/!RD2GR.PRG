*************************************************
* NOME.....: !RD2GR.PRG                         *
* FUNCAO...: RD2GR()                            *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: RD2GR(<expr num>)                  *
* DESCRI€AO: Transf. um ang. de radiano p/ grau *
*************************************************
FUNCTION RD2GR
PARAMETER nRadians 
RETURN (180 * (nRadians/PI()))
*******************************