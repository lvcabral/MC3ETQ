**********************************************************
* NOME.....: !BLOAD.PRG                                  *
* FUNCAO...: BLOAD()                                     *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: BLOAD(<expr carac>)                         *
* DESCRI€AO: Le tela em um arquivo no formato BSAVE      *
**********************************************************
************************
Function BLoad( NomArq )
************************
LOCAL Buff,Arq,Tam

If PCount()<1
   Return(.f.)
EndIf
If ValType(NomArq)#"C"
   Return(.f.)
EndIf
If ! File(NomArq)
   Return(.f.)
EndIf
Arq=FOpen(NomArq,0)
If Arq<0
   Return(.f.)
EndIf
Tam=FSeek(Arq,0,2)-8
Buff=Repl(Chr(0),Tam)
FSeek(Arq,7,0)
If FRead(Arq,@Buff,Tam)#Tam
   FClose(Arq)
   Return(.f.)
endif
FClose(Arq)
RestTela(Buff)
Return(.t.)
*******************************
