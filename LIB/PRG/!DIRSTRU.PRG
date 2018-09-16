**********************************************************
* NOME.....: !DIRSTRU.PRG                                *
* FUNCAO...: DirStructure()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: DirStructure( [<cDrv> )                     *
* DESCRI€AO: Retorna um array com os Diret¢rios do Drive *
**********************************************************
#include "Prograph.ch"
Function DirStructure( cDrv )
LOCAL aDirAux:={},aDirStr:={},cDir,nIdx,nCtd:=1
If ValType(cDrv)#"C".or.Empty(cDrv)
   cDrv:=Left(NomeDir(),2)
Endif
cDir:=cDrv+"\"
aAdd(aDirStr,cDir)

Do Process
   cDir:=aDirStr[nCtd]
   aDirAux:=Directory(cDir+"*.*","DH")
   For nIdx = 1 to Len(aDirAux)
       If "D"$aDirAux[nIdx][5].and.Left(aDirAux[nIdx][1],1)#"."
          aAdd(aDirStr,cDir+Trim(aDirAux[nIdx][1])+"\")
       EndIf
   Next
   nCtd++
Until nCtd>Len(aDirStr)

aSort(aDirStr)
aEval(aDirStr,{|val,idx| aDirStr[idx]:=If(idx>1,Left(val,len(val)-1),val)})
Return (aDirStr)

