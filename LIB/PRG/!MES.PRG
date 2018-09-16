*************************************************
* NOME.....: !MES.PRG                           *
* FUNCAO...: MES()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: MES(< expr data>)                  *
* DESCRI€AO: RETORNA O MES EM PORTUGUES         *
*************************************************

FUNC MES

PARAM DATA1
PRIVA MES,MESEXT

IF TYPE("DATA1")="N"
   MES=DATA1
ELSE
   MES=MONTH(DATA1)
ENDIF
IF MES=1
   MESEXT="Janeiro"
ELSEIF MES=2
   MESEXT="Fevereiro"
ELSEIF MES=3
   MESEXT="Marco"
ELSEIF MES=4
   MESEXT="Abril"
ELSEIF MES=5
   MESEXT="Maio"
ELSEIF MES=6
   MESEXT="Junho"
ELSEIF MES=7
   MESEXT="Julho"
ELSEIF MES=8
   MESEXT="Agosto"
ELSEIF MES=9
   MESEXT="Setembro"
ELSEIF MES=10
   MESEXT="Outubro"
ELSEIF MES=11
   MESEXT="Novembro"
ELSEIF MES=12
   MESEXT="Dezembro"
ELSE
   MESEXT=""
ENDIF

RETURN (MESEXT)
*******************************