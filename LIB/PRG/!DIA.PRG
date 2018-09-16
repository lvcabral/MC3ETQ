*************************************************
* NOME.....: !DIA.PRG                           *
* FUNCAO...: DIA()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL      *
* SINTAXE..: DIA(< expr data>)                  *
* DESCRI€AO: RETORNA O DIA EM PORTUGUES         *
*************************************************

FUNC DIA

PARAMETERS DATA1

DIA=DOW(DATA1)
IF DIA=1
   DIAEXT="Domingo"
ELSEIF DIA=2
   DIAEXT="Segunda"
ELSEIF DIA=3
   DIAEXT="Terca"
ELSEIF DIA=4
   DIAEXT="Quarta"
ELSEIF DIA=5
   DIAEXT="Quinta"
ELSEIF DIA=6
   DIAEXT="Sexta"
ELSEIF DIA=7
   DIAEXT="Sabado"
ENDIF

RETURN (DIAEXT)

*******************************