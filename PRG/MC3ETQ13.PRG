****************************************************************************
**  Programa.........: MC3ETQ v1.3 (C) Copyright 1991,1992                **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87 & Turbo "C" v2.0                 **
**  Descri‡„o........: Programa Gerador de Etiquetas Gr ficas.            **
**  Data de Cria‡„o..: 06/12/91  Ultima Altera‡„o..: 27/06/92             **
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
titulo="MC3ETQ v1.3 - Gerador de Etiquetas Graficas - (C) 1991,1992 - MC3 Informatica"
if checksum(right(titulo,15))#1360
   clear
   ? "Erro: Programa Adulterado !"
   music(5)
   reboot()
endif   
tb=0
setcancel(.f.)
modograf(6)
mouse(0,@tb)
continua=.t.
escreve(1,centra(titulo),titulo,1)
arqetq=" "
store "" to et_lin1,et_lin2,et_lin3,et_lin4,et_lin5
private lintxt[5]
afill(lintxt,"")
numcol=3
spcetq=12
linetq=2
tipimp=1
et_sepa=spcetq
et_lins=linetq
et_impr=tipimp
arq=fopen(nomarq,0)
buff=space(572)
tam=fseek(arq,0,2)
totfig=int(tam/572)
if rat("\",nomarq)#0
   nomarq=substr(nomarq,rat("\",nomarq)+1)
endif
linhah(6,0,639,1)
linhah(17,0,639,1)
quadrado(43,8,104,422,1)
for x = 1 to 5
 escreve(6+x,16,str(x,1)+chr(16),1)
 escreve(6+x,50,chr(17),1)
next
escreve(4,53-len(upper(alltrim(nomarq))),upper(alltrim(nomarq)),1)
escreve(14,1,"Configuracao das Etiquetas.: <Default>",1)
escreve(15,1,"Etiquetas por Linha........: "+alltrim(str(numcol,1)),1)
escreve(16,1,"Espaco entre as Etiquetas..: "+alltrim(str(spcetq,2)),1)
escreve(17,1,"Linhas entre as Etiquetas..: "+alltrim(str(linetq,1)),1)
escreve(18,1,"Tipo da Impressora.........: "+if(tipimp=1,"Epson-FX","Epson-LX"),1)
linhah(188,0,639,1)
escreve(24,1,"["+CHR(24)+" "+CHR(25)+"] Menu  ["+CHR(27)+" "+CHR(26)+"] Figuras  [HOME] Inicio  [END] Fim  [M] Movimenta  [ESC] Sai",1)
escreve(04,59," Digitar Texto ",1)
escreve(06,59," Alterar Texto ",1)
escreve(08,59," Ler  Etiqueta ",1)
escreve(10,59,"Salvar Etiqueta",1)
escreve(12,59,"   Imprimir    ",1)
escreve(14,59,"Listar  Figuras",1)
escreve(16,59," Mudar Arquivo ",1)
escreve(18,59,"  Configurar   ",1)
mnul1=29        
mnul2=41
opc=1
quadrado(mnul1,463,mnul2,597,1)
if tb>0
   mouse(1)
endif
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
  escreve(4,1, "Figura No. "+ltrim(str(v,4))+" / "+ltrim(str(totfig))+space(8),1)
  STORE 24 TO  lin, linp, lini
  bufft=buff
  strinv(@bufft)
  lingrafi(23,2,chr(7)+repl(chr(255),11)+chr(224),13)
  for t = 1 to 572 step 11
    if par(lin)
       lingrafp(linp,2,chr(7)+substr(bufft,t,11)+chr(224),13)
       linp=linp+1
    else
       lingrafi(lini,2,chr(7)+substr(bufft,t,11)+chr(224),13)
       lini=lini+1
    endif
    lin=lin+1
  next
  lingrafp(linp,2,chr(7)+repl(chr(255),11)+chr(224),13)
  do while .t.
     if tb>0
       tecla=inmouse()
     else
       tecla=inkey(0)
     endif  
     do case
     case tecla=27 && [esc] - Sai do Programa
       escreve(21,1,"Deseja Sair ? (S/N): [   ]",1)
       saida=edita(21,24,1,"L")
       if saida="S"
          continua=.f.
          v=10000
          exit
       endif
       escreve(21,1,space(30),1)
     case tecla=5 && para cima - Movimenta o Menu uma opcao acima
       if opc > 1
          quadrado(mnul1,463,mnul2,597,0)
          mnul1=mnul1-16
          mnul2=mnul2-16
          quadrado(mnul1,463,mnul2,597,1)
          opc=opc-1
       endif
     case tecla=24 && para baixo - Movimenta o Menu uma opcao abaixo
       if opc < 8
          quadrado(mnul1,463,mnul2,597,0)
          mnul1=mnul1+16
          mnul2=mnul2+16
          quadrado(mnul1,463,mnul2,597,1)
          opc=opc+1
       endif
     case tecla=13 && [Enter] - Escolhe a opcao atual do Menu
       ********************************
       ** Escreve as Linhas da Etiqueta
       if opc=1
          for ctl = 1 to 5
              lintxt[ctl]=edita(6+ctl,19,30,"X")
          next
       ****************************
       ** Altera Linhas da Etiqueta
       elseif opc=2
          escreve(21,1,"Altera Linha No.(1-5): [   ]",1)
          altlin=edita(21,26,1,"9")
          altlin=val(altlin)
          if altlin > 0 .and. altlin < 6
             lintxt[altlin]=edita(6+altlin,19,30,"X")
             escreve(21,1,space(28),1)
          else
             escreve(22,1,"Linha Invalida !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(21,1,space(28),1)
             escreve(22,1,space(33),1)
          endif
       ********************************
       ** Le Arquivo de Etiqueta (.etq)
       elseif opc=3
          escreve(21,1,"Digite o Nome do Arquivo: [          ]",1)
          arqetq=alltrim(edita(21,29,8,"!A9"))
          arqetq=arqetq+".ETQ"+space(8-Len(arqetq))
          if file(trim(arqetq))
             escreve(22,1,"Lendo o Arquivo...",1)
             restore from &arqetq additive
             lintxt[1]=et_lin1
             lintxt[2]=et_lin2 
             lintxt[3]=et_lin3
             lintxt[4]=et_lin4
             lintxt[5]=et_lin5 
             if (et_arqf#nomarq).and.file(et_arqf)
                fclose(arq)
                nomarq=et_arqf
                arq=fopen(et_arqf,0)
                tam=fseek(arq,0,2)
                totfig=int(tam/572)
                nomarq=alltrim(nomarq)
                escreve(4,39,"  "+space(12-Len(nomarq))+upper(nomarq),1)
             endif
             if et_figr > totfig
                et_figr=totfig
             endif
             fseek(arq,(572*(et_figr-1)),0)
             v=et_figr-1
             numcol=et_colu
             spcetq=et_sepa
             linetq=et_lins
             tipimp=et_impr
             escreve(14,1,"Configuracao das Etiquetas.: "+upper(arqetq),1)
             escreve(15,1,"Etiquetas por Linha........: "+alltrim(str(numcol,1)),1)
             escreve(16,1,"Espaco entre as Etiquetas..: "+alltrim(str(spcetq,2)),1)
             escreve(17,1,"Linhas entre as Etiquetas..: "+alltrim(str(linetq,1)),1)
             escreve(18,1,"Tipo da Impressora.........: "+if(tipimp=1,"Epson-FX","Epson-LX"),1)
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
             for ctl = 1 to 5
                 linha=if(len(lintxt[ctl])<30,lintxt[ctl]+space(31-len(lintxt[ctl])),left(lintxt[ctl],30))
                 escreve(6+ctl,19,linha,1)
             next
             exit
          else
             escreve(22,1,"Arquivo Inexistente !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
          endif
       ********************************************
       ** Salva Etiqueta Atual em um Arquivo (.etq)
       elseif opc=4
          escreve(21,1,"Digite o Nome do Arquivo: [          ]",1)
          arqetq=alltrim(edita(21,29,8,"!A9"))
          if ! empty(arqetq)
             arqetq=arqetq+".ETQ"+space(8-Len(arqetq))
             escreve(22,1,"Salvando...",1)
             et_arqf=nomarq
             et_lin1=lintxt[1]
             et_lin2=lintxt[2]
             et_lin3=lintxt[3]
             et_lin4=lintxt[4]
             et_lin5=lintxt[5]
             et_figr=v
             et_colu=numcol
             et_sepa=spcetq
             et_lins=linetq
             et_impr=tipimp
             save to &arqetq all like et_*
             escreve(14,1,"Configuracao das Etiquetas.: "+upper(alltrim(arqetq)),1)
          endif
          escreve(21,1,space(50),1)
          escreve(22,1,space(13),1)
       ********************
       ** Imprime Etiquetas
       elseif opc=5
          escreve(20,1,"Quantidade de Etiquetas: [      ]",1)
          altlin=val(edita(20,28,4,"9"))
          if altlin=0
             escreve(20,1,space(50),1)
             loop
          endif
          escreve(21,1,"Aperte uma tecla para iniciar... [ESC] Interrompe",1)
          if INKEY(0)=27
             escreve(20,1,space(50),1)
             escreve(21,1,space(50),1)
             loop
          endif
          IF ! ISPRINTER()
             escreve(22,1,"ERRO: Impressora nao Pronta!! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(20,1,space(50),1)
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
             LOOP
          ENDIF 
          if lastkey()#27
            set console off
            set print on
            escreve(22,1,"Processando.....",1)
            buft=buff+repl(chr(0),44)
            bufp=space(616)
            T2I(BUFT,@BUFP)
            escreve(22,1,"Imprimindo .....",1)
            do case
            case altlin < numcol
                impgraf(bufp,lintxt,altlin)
            case altlin%numcol = 0
                for cte = 1 to altlin step numcol
                    impgraf(bufp,lintxt,numcol)
                next
            other
                ctx=0
                for cte = 1 to int(altlin/numcol)
                    impgraf(bufp,lintxt,numcol)
                    ctx=ctx+1
                next
                impgraf(bufp,lintxt,altlin-(numcol*ctx))
            endcase 
            set console on
            set print off
          endif
          escreve(20,1,space(39),1)
          escreve(21,1,space(50),1)
          escreve(22,1,space(30),1)
       *************************************************
       ** Imprime Cat logo das Figuras do Arquivo (.FIG)
       elseif opc=6
          escreve(20,1,"Digite a Figura Inicial e a Final : [      "+chr(26)+"      ]",1)
          f1=val(edita(20,39,4,"9"))
          f2=val(edita(20,46,4,"9"))
          if f1 > totfig
             escreve(21,1,"Figura Inicial Maior que o Total!! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(20,1,space(51),1)
             escreve(21,1,space(50),1)
             LOOP
          elseif f1 < 1
             f1=1
          endif
          if f2 = 0
             f2 = totfig
          elseif f2 < f1
             escreve(21,1,"Figura Final Menor que a Inicial!! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(20,1,space(51),1)
             escreve(21,1,space(50),1)
             LOOP
          elseif f2 > totfig
             f2=totfig
          endif
          escreve(21,1,"Aperte uma tecla para iniciar... [ESC] Interrompe",1)
          INKEY(0)
          IF LASTKEY()#27
            IF ! ISPRINTER()
               escreve(22,1,"ERRO: Impressora nao Pronta!! Tecle [ENTER]",1)
               do while inkey()#13
               enddo
               escreve(20,1,space(51),1)
               escreve(21,1,space(50),1)
               escreve(22,1,space(50),1)
               LOOP
            ENDIF 
            PRIVATE BUF1,BUF2,BUF3,BUF4,BUF5,CAT,CTT,CTL,CTF
            store repl(chr(0),616) to buf1,buf2,buf3,buf4,buf5
            nomarq=upper(nomarq)
            bufk=buff
            LUGAR=FSEEK(ARQ,0,1)
            fseek(arq,(572*(F1-1)),0)
            CTL=7
            CTF=F1-1
            TOTCAT=(F2-F1)+1
            set console off
            set print on
            IF TOTCAT<5
               ?
               imprime(CP(15)+CHR(14)+SPACE(10)+IF(tipimp>1,space(4),""))
               imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
               imprime(chr(13)+chr(14)+space(10)+IF(tipimp>1,space(4),""))
               imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
               ?
               imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ+CHR(13))
               imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ)
               ? CHR(18)
               ?
               IMPMENOR(TOTCAT)
            ELSE
              FOR CTT = 1 TO INT(TOTCAT/5)
                TNUM=CP(15)+SPACE(11)+IF(tipimp>1,space(2),"")
                IF CTL = 7
                   ?
                   imprime(CP(15)+CHR(14)+SPACE(10)+IF(tipimp>1,space(4),""))
                   imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
                   imprime(chr(13)+chr(14)+space(10)+IF(tipimp>1,space(4),""))
                   imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
                   ?
                   imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ+CHR(13))
                   imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ)
                   ? CHR(18)
                   ?
                   CTL=0
                ENDIF
                escreve(22,1,"Processando.....",1)
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF1)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF2)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF3)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF4)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(11)+IF(tipimp>1,space(5),"")
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF5)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))
 
                escreve(22,1,"Imprimindo .....",1)
                IMPCAT(BUF1,BUF2,BUF3,BUF4,BUF5,5)
                IF INKEY()=27.or.LASTKEY()=27
                   EXIT
                ENDIF
                CTL=CTL+1
                IF CTL=7
                   ?
                   imprime(tnum+CHR(18))
                   EJECT
                ELSE
                   ? tnum+CHR(18)
                   ?
                   ?
                   ?
                ENDIF
              NEXT
              IF TOTCAT%5 # 0 .AND. LASTKEY()#27
                IF CTL = 7
                  ?
                  imprime(CP(15)+CHR(14)+SPACE(10)+IF(tipimp>1,space(4),""))
                  imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
                  imprime(chr(13)+chr(14)+space(10)+IF(tipimp>1,space(4),""))
                  imprime("MC3ETQ v1.3 - Gerador de Etiquetas Graficas")
                  ?
                  imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ+CHR(13))
                  imprime(CHR(14)+SPACE(19)+IF(tipimp>1,space(4),"")+"Arquivo: "+NOMARQ)
                  ? CHR(18)
                  ?
                  CTL=0
                ENDIF
                IMPMENOR(TOTCAT-(CTF-(F1-1)))
              ENDIF
            ENDIF
            set console on
            set print off
            FSEEK(ARQ,LUGAR)
            buff=bufk
          ENDIF
          escreve(20,1,space(51),1)
          escreve(21,1,space(50),1)
          escreve(22,1,space(30),1)
       ***********************************
       ** Muda o Arquivo de Figuras (.fig)
       elseif opc=7
          escreve(21,1,"Digite o Nome do Arquivo: [          ]",1)
          oldarq=nomarq
          nomarq=alltrim(edita(21,29,8,"!A9"))
          nomarq=nomarq+".FIG"
          if file(trim(nomarq))
             escreve(22,1,"Lendo o Arquivo...",1)
             fclose(arq)
             arq=fopen(nomarq,0)
             tam=fseek(arq,0,2)
             totfig=int(tam/572)
             et_figr=1
             fseek(arq,(572*(et_figr-1)),0)
             v=et_figr-1
             escreve(4,39,"  "+space(12-Len(nomarq))+upper(nomarq),1)
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
             exit
          else
             nomarq=oldarq
             escreve(22,1,"Arquivo Inexistente !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
          endif
       *********************************************
       ** Configura o Ambiente do Programa          
       elseif opc=8
          escreve(21,1,"Digite o No. de Etiquetas por Linha (1-4)",1)
          altlin=edita(15,30,1,"9")
          if val(altlin)>0 .and. val(altlin)<5
             numcol=val(altlin)
          elseif empty(altlin)
             escreve(15,30,ltrim(str(numcol,1))+"  ",1)
          else
             escreve(22,1,"Numero Invalido !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(15,30,ltrim(str(numcol,1))+"  ",1)
             escreve(21,1,space(50),1)
             escreve(22,1,space(40),1)
             loop
          endif
          escreve(21,1,"Digite o No. de Espacos entre as Etiquetas",1)
          altspc=edita(16,30,2,"9")
          if ! empty(altspc)
             spcetq=val(altspc)
          endif
          escreve(16,30,ltrim(str(spcetq,2))+"  ",1)
          escreve(21,1,"Digite o No. de Linhas entre as Etiquetas ",1)
          altnln=edita(17,30,1,"9")
          if ! empty(altnln)
             linetq=val(altnln)
          endif
          escreve(17,30,ltrim(str(linetq,2))+"  ",1)
          escreve(21,1,"Digite o Tipo de Impressora: 1-Epson-FX 2-Epson-LX",1)
          escreve(18,30,space(10),1)
          altimp=edita(18,30,1,"9")
          if altimp$"12"
             tipimp=val(altimp)
             escreve(21,1,space(50),1)
          elseif empty(altimp)   
             escreve(21,1,space(50),1)
          else   
             escreve(22,1,"Impressora Invalida !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(21,1,space(50),1)
             escreve(22,1,space(50),1)
          endif
          escreve(18,1,"Tipo da Impressora.........: "+if(tipimp=1,"Epson-FX","Epson-LX"),1)
       endif
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
     case upper(chr(tecla))="M"
       escreve(21,1,"Movimenta para Figura No.: [      ]",1)
       cnum=edita(21,30,4,"9")
       escreve(21,1,space(70),1)
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
if tb>0
  mouse(2)
endif
modograf(3)
@ 0,0 say ""
? titulo
?
fclose(arq)
quit
*****************
FUNCTION IMPMENOR
*****************
PARAM NCOLU
TNUM=CP(15)+SPACE(11)+IF(tipimp>1,space(2),"")
CTL=0
escreve(22,1,"Processando.....",1)
FREAD(ARQ,@BUFF,572)
buft=buff+repl(chr(0),44)
T2I(BUFt,@BUF1)
ctf=ctf+1
det=ltrim(str(ctf,4))
TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
IF NCOLU>=2
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF2)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
ENDIF
IF NCOLU>=3
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF3)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)+IF(tipimp>1,space(3),"")
ENDIF
IF NCOLU>=4
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF4)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))
ENDIF
escreve(22,1,"Imprimindo .....",1)
IMPCAT(BUF1,BUF2,BUF3,BUF4,BUF5,NCOLU)
CTL=CTL+1
IF CTL=7
   ?
   imprime(tnum+CHR(18))
   EJECT
ELSE
   ? tnum+CHR(18)
   ?
   ?
   ?
ENDIF
RETURN(.T.)
****************
FUNCTION IMPGRAF
****************
PARAMETERS BUFP,LINHA,NETQ

IF TYPE("NETQ")#'N'
   NETQ=1
ENDIF
IF NETQ > 4
   NETQ=4
ENDIF   
IF TYPE("LINHA")#"A"
   PRIVATE LINHA[5]
   AFILL(LINHA," ")
ENDIF
IF LEN(LINHA)<5
   ? "ERRO: TAMANHO DO VETOR MENOR DO QUE O ESPERADO"
   RETURN(.F.)
ENDIF     
************* ROTINA DE IMPRESSAO *************
FOR J=1 TO 7
  imprime(CHR(13)+IF(J=1,"",CHR(27)+"J"+CHR(24-DESLOC)))
  LN=SPACE(12)+if(tipimp>1,space(02),"")
  FOR T=1 TO NETQ
    imprime(CHR(27)+'L'+CHR(88)+CHR(0)+substr(BUFP,(j*88)-87,88))
    IF J>0.AND.J<5
     LN=LN+IF(LEN(LINHA[j])>30,LEFT(LINHA[j],30),LINHA[j]+SPACE(30-LEN(LINHA[j])))
    ELSEIF J=6
     LN=LN+IF(LEN(LINHA[5])>30,LEFT(LINHA[5],30),LINHA[5]+SPACE(30-LEN(LINHA[5])))
    ELSE
     LN=SPACE(30)
    ENDIF
    IF T<NETQ
       LN=LN+SPACE(12+spcetq)+if(tipimp>1,space(08),"")
       imprime(CP(15)+SPACE(31+spcetq)+if(tipimp>1,space(06),"")+chr(18))
    ENDIF   
  NEXT    
  IF (J*2)<10
     DESLOC=(J*2)*3
     imprime(CHR(13)+CHR(27)+"J"+CHR(DESLOC))   && RETORNO DO CARRO E AVANCO
     imprime(CP(15)+LN+CHR(18))
     imprime(CHR(13)+CP(15)+LN+CHR(18))
  ELSEIF (J*2)=12
     DESLOC=6
     imprime(CHR(13)+CHR(27)+"J"+CHR(DESLOC))   && RETORNO DO CARRO E AVANCO
     imprime(CP(15)+LN+CHR(18))
     imprime(CHR(13)+CP(15)+LN+CHR(18))
  ELSE
     DESLOC=0
  ENDIF
NEXT
FOR csl=1 to linetq
   ?
NEXT   
RETURN(.T.)

***************
FUNCTION IMPCAT
***************
PARAMETERS BUF1,BUF2,BUF3,BUF4,BUF5,NCOL
PRIVATE J,T,BUFF
************* ROTINA DE IMPRESSAO *************
FOR J=1 TO 7
  imprime(CHR(13)+CHR(27)+"J"+CHR(24)+SPACE(8))
  FOR T=1 TO NCOL
    DO CASE
    CASE T=1
       BUFF=substr(BUF1,(j*88)-87,88)
    CASE T=2
       BUFF=substr(BUF2,(j*88)-87,88)
    CASE T=3
       BUFF=substr(BUF3,(j*88)-87,88)
    CASE T=4
       BUFF=substr(BUF4,(j*88)-87,88)
    CASE T=5
       BUFF=substr(BUF5,(j*88)-87,88)
    ENDCASE    
    imprime(CHR(27)+'L'+CHR(88)+CHR(0)+BUFF)
    if T<NCOL
       imprime(SPACE(8))
    endif   
  NEXT    
NEXT
RETURN(.T.)
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
****************
function inmouse
do while .t.
  store 0 to lin,col,but,tec
  mouse(3,@lin,@col,@but)
  tec=inkey()
  do case
  case but=2
     tone(300,1)
     return(27)
  case but=1
     if lin>191.and.(col>15.and.col<25)
        tone(100,1)
        return(5)
     elseif lin>191.and.(col>31.and.col<41)
        tone(100,1)
        return(24)
     elseif lin>191.and.(col>111.and.col<121)
        tone(100,1)
        return(19)
     elseif lin>191.and.(col>127.and.col<137)
        tone(100,1)
        return(4)
     elseif lin>191.and.(col>231.and.col<264)
        tone(100,1)
        return(1)
     elseif lin>191.and.(col>351.and.col<375)
        tone(100,1)
        return(6)
     elseif lin>191.and.(col>440.and.col<450)
        tone(100,1)
        return(asc("M"))
     elseif lin>191.and.(col>560.and.col<584)
        tone(100,1)
        return(27)
     elseif col>462.and.col<598.and.lin>28.and.lin<153
          do case
          case lin < 42
             opx=1
          case lin < 42 + 16
             opx=2
          case lin < 42 + 16 * 2
             opx=3
          case lin < 42 + 16 * 3
             opx=4
          case lin < 42 + 16 * 4
             opx=5
          case lin < 42 + 16 * 5
             opx=6
          case lin < 42 + 16 * 6
             opx=7
          case lin < 42 + 16 * 7 
             opx=8
          endcase
          if opx=opc
             tone(100,1)
             return(13)
          endif   
     endif
  case tec#0
     return(tec)
  endcase
enddo
************
function cp
param cod
if tipimp=1
   return(ci(15))
else
   return(chr(15))
endif
