**********************************************************
* NOME.....: !BSAVE.PRG                                  *
* FUNCAO...: BSAVE()                                     *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: BSAVE(<expr carac>)                         *
* DESCRI€AO: Salva a tela em um arquivo no formato BSAVE *
**********************************************************

Function BSave( NomArq )

LOCAL Buff,Arq,Modo,Cab,Tam

If PCount()<1
   Return(.f.)
Endif
If ValType(NomArq)#"C"
   Return(.f.)
EndIf
Modo=ModoGraf()
Do Case
Case Modo<=1
    Buff=SaveScreen(0,0,24,39)
    Cab=Chr(253)+Chr(0)+Chr(184)+Chr(0)+Chr(0)+Chr(208)+Chr(7)
Case Modo<=3.or.Modo=7
    Buff=SaveScreen(0,0,MaxRow(),MaxCol())
    Cab=Chr(253)+Chr(0)+Chr(184)+Chr(0)+Chr(0)+Chr(160)+Chr(15)
Case Modo<=6
    Buff=Repl(Chr(0),16192)
    SalvaTela(@buff)
    Cab=Chr(253)+Chr(0)+Chr(184)+Chr(0)+Chr(0)+"@?"
Other
    Buff="Modo Grafico Invalido !"
    Cab=""
EndCase
Arq=FCreate(NomArq,0)
If Arq<0
   Return(.f.)
EndIf
Tam=Len(Buff)+8
If FWrite(Arq,Cab+Buff+Chr(26))#Tam
   FClose(Arq)
   Return(.f.)
Endif
FClose(Arq)
Return(.t.)
*******************************
