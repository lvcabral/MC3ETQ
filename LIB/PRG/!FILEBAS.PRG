****
*  FileBase( <cFile> ) --> cFileBase
*  Extract the eight letter base name from a filename
*  Adaptada para Summer'87 por Marcelo L. L. Cabral em 15/04/92
**
FUNCTION FileBase
   PARAM cFile 
   PRIVATE nPos1, nPos2, cFileBase
   nPos1 = RAT("\", cFile)
   nPos2 = AT(":", cFile)
   DO CASE
   CASE nPos1 != 0
      ** Strip full path name
      cFileBase = SUBSTR(cFile, nPos1 + 1)
   CASE nPos2 != 0
      ** Strip drive letter
      cFileBase = SUBSTR(cFile, nPos2 + 1)
   OTHERWISE
      cFileBase = cFile
   ENDCASE
   nPos1 = AT(".", cFileBase)
   ** Strip file extension, if any
   IF  nPos1 != 0
      cFileBase = SUBSTR(cFileBase, 1, nPos1 - 1)
   ENDIF

RETURN cFileBase


