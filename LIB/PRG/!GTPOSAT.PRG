*嬪様様様様様様様様様様様様様様様様様様様様様様様様様邑
*� NOME.....: !GTPOSAT.PRG                            �
*� FUNCAO...: GetPosAttrib()                          �
*� AUTOR....: MARCELO LEAL LIMAVERDE CABRAL           �
*� SINTAXE..: GetPosAttrib(nRow,nCol)                 �
*� DESCRI��O: Retorna o Atributo da Posi��o enviada   �
*塒様様様様様様様様様様様様様様様様様様様様様様様様様余
Function GetPosAttrib( nLin, nCol )
Return ( Asc(SubStr(SaveScreen(nLin,nCol,nLin,nCol),2,1)) )

