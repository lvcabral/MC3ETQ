********************************************************
Function Maiuscula(texto)
local excecao:={" Do "," Dos "," Da "," Das "," De ", " E "," Del "}
novotexto=space(1)+LOWER(texto)
FIM:=LEN(TEXTO)
FOR I = 1 TO FIM
   IF SUBSTR(novotexto,i,1)=" "
      novotexto=  STUFF(novotexto,i+1,1,;
      UPPER(SUBSTR(novotexto,i+1,1)))
   ENDIF
NEXT
TAMANHO=LEN(EXCECAO)
FOR i=1 TO TAMANHO
   IF EXCECAO[i] $ novotexto
      novotexto=STUFF(novotexto,AT(EXCECAO[i],novotexto),;
      LEN(EXCECAO[i]),LOWER(EXCECAO[i]))
   ENDIF
NEXT
RETURN (LTRIM(novotexto))
