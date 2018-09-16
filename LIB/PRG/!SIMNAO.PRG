***************
FUNCTION SIMNAO
***************
PARAM OPC,MSG,SOM
IF PCOUNT()<2
   MSG=.T.
ENDIF
IF PCOUNT()<3
   SOM=.T.
ENDIF
IF OPC$"sS"
   IF MSG
      @ ROW(),COL()+1 SAY "- Sim"
   ENDIF
   RETURN(.T.)
ELSEIF OPC$"nN"
   IF MSG
      @ ROW(),COL()+1 SAY "- N„o"
   ENDIF
   RETURN(.T.)
ELSE      
   IF SOM
      TONE(300,3)
   ENDIF
   RETURN(.F.)
ENDIF