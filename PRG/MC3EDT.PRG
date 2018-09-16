****************************************************************************
**  Programa.........: MC3EDT v1.0 (C) Copyright 1992                     **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87 & Turbo "C" v2.0                 **
**  Descri‡„o........: Programa Editor de Figuras.                        **
**  Data de Cria‡„o..: 20/04/92  Ultima Altera‡„o..: 21/04/92             **
****************************************************************************
param nomarq
if pcount()<1
   ? "Erro: Falta Nome do Arquivo de Figuras"
   ?
   quit
endif
if empty(fileext(nomarq))
   nomarq=nomarq+".FIG"
endif
if ! file(nomarq)
   ? "Erro: Arquivo [ &nomarq ] n„o Existe"
   ?
   quit
endif
if file("MC3ED1.EXE")
   rename mc3ed1.exe to mc3edt.ovl
endif

if ! file("MC3EDT.OVL")
   ? "Erro: Arquivo Overlay n„o Encontrado"
   ?
   quit
endif

titulo="MC3EDT v1.0 - Editor de Figuras - (C)opyright 1992 by MC3 Informatica"
if checksum(right(titulo,15))#1360
   ? "Erro: Programa Adulterado !"
   ?
   quit
endif   
setcancel(.f.)
modograf(6)
continua=.t.
aguarde="... aguarde ..."
escreve(1,centra(titulo),titulo,1)
arq=fopen(nomarq,2)
buff=space(572)
tam=fseek(arq,0,2)
totfig=int(tam/572)
if rat("\",nomarq)#0
   nomarq=upper(substr(nomarq,rat("\",nomarq)+1))
else
   nomarq=upper(nomarq)   
endif
linhah(6,0,639,1)
linhah(17,0,639,1)
linhah(188,0,639,1)
quadrado(43,248,104,366,1)
escreve(14,31,nomarq,1)
escreve(24,1,"["+CHR(27)+" "+CHR(26)+"] Movem  [HOME] Inicio  [END] Fim  [V] Vai para  [ENTER] Edita  [ESC] Sai",1)
opc=1
do while continua
 fseek(arq,0)
 v=1
 do while v <= totfig
  if v>0
     if fread(arq,@buff,572) # 572
        modograf(3)
        ? "Erro: Houve Falha na Leitura do Arquivo"
        fclose(arq)
        quit
     endif
  endif
  escreve(4,31, "Figura No. "+ltrim(str(v,4))+space(4),1)
  STORE 24 TO  lin, linp, lini
  bufft=buff
  strinv(@bufft)
  lingrafi(23,32,chr(7)+repl(chr(255),11)+chr(224),13)
  for t = 1 to 572 step 11
    if par(lin)
       lingrafp(linp,32,chr(7)+substr(bufft,t,11)+chr(224),13)
       linp=linp+1
    else
       lingrafi(lini,32,chr(7)+substr(bufft,t,11)+chr(224),13)
       lini=lini+1
    endif
    lin=lin+1
  next
  lingrafp(linp,32,chr(7)+repl(chr(255),11)+chr(224),13)
  do while .t.
     tecla=inkey(0)
     do case
     case tecla=27 && [esc] - Sai do Programa
       escreve(21,25,"Deseja Sair ? (S/N): [   ]",1)
       saida=edita(21,48,1,"L")
       if saida="S"
          continua=.f.
          v=10000
          exit
       endif
       escreve(21,25,space(30),1)
     case tecla=13 && [Enter] - Escolhe a figura atual 
       escreve(21,centra(aguarde),aguarde,1)
       tela=repl(chr(0),16192)
       salvatela(@tela)
       if file("MC3ED.SHP")
          erase MC3ED.SHP
       endif
       if file("TEMP.SHP")
          erase TEMP.SHP
       endif
       if file("TEMP.SDR")
          erase TEMP.SDR
       endif
       atemp=fcreate("MC3ED.SHP")
       fwrite(atemp,chr(11)+"4X"+chr(0)+buff+chr(0))
       fclose(atemp)
       rename mc3edt.ovl to mc3ed1.exe

       run mc3ed1

       modograf(6)
       resttela(tela)
       if file("TEMP.SHP")
          btemp=fopen("TEMP.SHP")
          btam=fseek(btemp,-573,2)
          bufn=repl(chr(0),572)
          fread(btemp,@bufn,572)
          fclose(btemp)
          erase temp.shp
          erase temp.sdr
          if v>0
             fseek(arq,(572*(v-1)),0)
             fwrite(arq,bufn)
          else
             fseek(arq,0,2)
             fwrite(arq,bufn)
             totfig=totfig+1
             v=totfig
          endif
       endif
       fseek(arq,(572*(v-1)),0)
       v=v-1
       rename mc3ed1.exe to mc3edt.ovl
       erase mc3ed.shp
       escreve(21,centra(aguarde),space(15),1)
       exit
     case tecla=1 && [home] - Primeira Figura
       v=totfig
       exit
     case tecla=6 && [end]  - Ultima Figura
         fseek(arq,(572*(totfig-1)),0)
         v=totfig-1
         exit
     case tecla=19 && [<-] - Volta uma Figura
      if v = 0  
         fseek(arq,(572*(totfig-1)),0)
         v=totfig-1
         exit
      elseif v=1
         v=-1
         buff=repl(chr(0),572)
         fseek(arq,0)
         exit
      elseif v=2
         v=totfig
         exit
      else
        fseek(arq,-(572*2),1)
        v=v-2
        exit
      endif
     case tecla=4 && [->] - Avanca uma Figura
       if v=totfig
          v=-1
          buff=repl(chr(0),572)
          fseek(arq,0)
       endif
       exit
     case upper(chr(tecla))="V"
       escreve(21,23,"Vai para Figura No.: [      ]",1)
       cnum=edita(21,46,4,"9")
       escreve(21,23,space(30),1)
       vaifig=val(cnum)
       if vaifig > totfig
          vaifig=totfig
       endif
       if vaifig = 0
          v=-1
          buff=repl(chr(0),572)
          fseek(arq,0)
       else   
          fseek(arq,(572*(vaifig-1)),0)
          v=vaifig-1
       endif
       exit
     endcase
  enddo 
  v=v+1
 enddo
enddo
modograf(3)
@ 0,centra(titulo) say titulo
? 
?
fclose(arq)
quit
**************
function edita
param lin,col,qtd,pic
private cnum,dignum
pic=upper(pic)
cnum=""
dignum=0
escreve(lin,col,"_"+space(qtd-1),1)
do while .t.
   dignum=inkey()
   if dignum=13
      exit
   elseif (dignum>47 .and. dignum<58).and.;
          ("9"$upper(pic).or."X"$upper(pic))
    if len(cnum) < qtd
      cnum=cnum+chr(dignum)
      escreve(lin,col+(len(cnum)-1),chr(dignum)+"_",1)
    endif
   elseif (isalpha(chr(dignum)).or.dignum=32).and.;
          ("A"$upper(pic).or."X"$upper(pic))
    if len(cnum) < qtd
      if "!"$upper(pic)
         dignum=asc(upper(chr(dignum)))
      endif
      cnum=cnum+chr(dignum)
      escreve(lin,col+(len(cnum)-1),chr(dignum)+"_",1)
    endif
   elseif ((dignum>=32.and.dignum<=47).or.(dignum>=58.and.dignum<=64).or.(dignum>=91.and.dignum<=96));
          .and."X"$upper(pic)
    if len(cnum) < qtd
      cnum=cnum+chr(dignum)
      escreve(lin,col+(len(cnum)-1),chr(dignum)+"_",1)
    endif
   elseif upper(chr(dignum))$"SN".and.upper(pic)="L"
    if len(cnum) < qtd
      dignum=asc(upper(chr(dignum)))
      cnum=cnum+chr(dignum)
      escreve(lin,col+(len(cnum)-1),chr(dignum)+"_",1)
    endif
   elseif dignum=8.and.len(cnum)>0
      cnum=if(len(cnum)>1,left(cnum,len(cnum)-1),"")
      escreve(lin,col+len(cnum),"_ ",1)
   endif
enddo
escreve(lin,col,cnum+space((qtd+1)-len(cnum)),1)
return(cnum)
