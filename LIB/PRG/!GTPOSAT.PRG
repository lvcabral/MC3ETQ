*ีออออออออออออออออออออออออออออออออออออออออออออออออออออธ
*ณ NOME.....: !GTPOSAT.PRG                            ณ
*ณ FUNCAO...: GetPosAttrib()                          ณ
*ณ AUTOR....: MARCELO LEAL LIMAVERDE CABRAL           ณ
*ณ SINTAXE..: GetPosAttrib(nRow,nCol)                 ณ
*ณ DESCRI€O: Retorna o Atributo da Posio enviada   ณ
*ิออออออออออออออออออออออออออออออออออออออออออออออออออออพ
Function GetPosAttrib( nLin, nCol )
Return ( Asc(SubStr(SaveScreen(nLin,nCol,nLin,nCol),2,1)) )

