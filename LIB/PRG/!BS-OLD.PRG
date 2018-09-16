**********************************************************
* NOME.....: !BSAVE.PRG                                  *
* FUNCAO...: BSAVE()                                     *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL               *
* SINTAXE..: BSAVE(<expr carac>)                         *
* DESCRI€AO: Salva a tela em um arquivo no formato BSAVE *
**********************************************************

FUNC BSAVE

PARAM nomarq 
PRIVA buff,arq,modo,cab,tam

if pcount()<1
   return(.f.)
endif
if type("nomarq")#"C"
   return(.f.)
endif
modo=modograf()
do case
case modo<=1
    buff=repl(chr(0),2000)
    cab=chr(253)+chr(0)+chr(184)+chr(0)+chr(0)+chr(208)+chr(7)
case modo<=3.or.modo=7
    buff=repl(chr(0),4000)
    cab=chr(253)+chr(0)+chr(184)+chr(0)+chr(0)+chr(160)+chr(15)
case modo<=6
    buff=repl(chr(0),16192)  
    cab=chr(253)+chr(0)+chr(184)+chr(0)+chr(0)+"@?"
other
    buff="Modo Grafico Invalido !"
    cab=""
endcase
if modo<7
  SalvaTela(@buff)
endif
arq=fcreate(nomarq,0)
if arq<0
   return(.f.)
endif
tam=len(buff)+8
if fwrite(arq,cab+buff+chr(26))#tam
   return(.f.)
endif
return(.t.)
*******************************
