****
*  FileExt( <cFile> ) --> cFileExt
*  Extract the three letter extension from a filename
*  Adaptada para Summer'87 por Marcelo L. L. Cabral em 15/04/92
**
FUNCTION FileExt
   PARAM cFile 
   PRIVATE nPos, cFileExt
   nPos = RAT(".", cFile)
   IF nPos != 0
      cFileExt = SUBSTR(cFile, nPos + 1)
   ELSE
      cFileExt = ""
   ENDIF

RETURN cFileExt
