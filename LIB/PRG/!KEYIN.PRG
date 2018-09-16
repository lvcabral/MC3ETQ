******************************************************************************
* NOME.....: !KEYIN.PRG                                                      *
* FUNCAO...: KEYIN()                                                         *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL                                   *
* SINTAXE..: KEYIN(<lin>,<col>,<msg>,@<var>[,<pic>,<vld>,<clr>,<mld>,<smb]>) *
* DESCRI€AO: Edita uma Variavel/Campo.                                       *
******************************************************************************
Function KeyIn(lin,col,msg,var,pic,vld,clr,mld,smb)
Local cor,cur,tla,tam,olin,ocol
If ValType(pic)#"C"
   pic=""
Endif
If ValType(vld)#"B"
   vld={|item| .t.}
Endif
If ValType(clr)#"C"
   clr="w+/b,b/w"
Endif
If ValType(mld)#"N"
   mld=3
Endif
If ValType(smb)#"L"
   smb=.f.
Endif

cor=setcolor()
cur=setcursor()
olin=row()
ocol=col()
msg=alltrim(msg)
tam=len(msg+transform(var,pic))+4

if smb
  tla=savescreen(lin,col,lin+3,col+tam+1)
  Cor_tela(lin+1,col+1,lin+3,col+tam+1,"N+/N")
else
  tla=savescreen(lin,col,lin+2,col+tam)
endif

setcolor(clr)
scroll(lin,col,lin+2,col+tam,0)
do case
case mld=1
   @ lin,col to lin+2,col+tam
case mld=2
   @ lin,col to lin+2,col+tam double
Other
   janela(lin,col,lin+2,col+tam)
endcase
@ lin+1,col+2 say msg
@ lin+1,col+3+len(msg) get var pict pic valid eval(vld,var)
setcursor(1)
read
if smb
  restscreen(lin,col,lin+3,col+tam+1,tla)
else
  restscreen(lin,col,lin+2,col+tam,tla)
endif
setcolor(cor)
setcursor(cur)
setpos(olin,ocol)
return(updated())
*********************************** eof *************************************
