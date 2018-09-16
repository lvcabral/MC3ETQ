***********************************
Function ReadDBF(cArq,aCpos,aDados)
***********************************
Local nR,nC
If File(cArq)
   Use (cArq) New
   aCpos:=DBStruct()
   If LastRec()>0
      aDados:=Array(LastRec(),FCount())
      For nR = 1 to LastRec()
          For nC = 1 to FCount()
              aDados[nR][nC]:=FieldGet(nC)
          Next
          Skip
      Next
   Endif
Else
   Return(.f.)
Endif
DBCloseArea()
Return (.t.)
************************************
Function WriteDBF(cArq,aCpos,aDados)
************************************
Local nR,nC
DBCreate(cArq,aCpos)
If File(cArq)
   Use (cArq) New
   For nR = 1 to Len(aDados)
       DBAppend()
       For nC = 1 to FCount()
           FieldPut(nC,aDados[nR][nC])
       Next
   Next
Else
   Return (.f.)
Endif
DBCloseArea()
Return (.t.)
