****************************************************************************
**  Programa.........: MC3ETQ v1.0 (C) Copyright 1991                     **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87 & Turbo "C" v2.0                 **
**  Descri‡„o........: Programa Gerador de Etiquetas Gr ficas.            **
**  Data de Cria‡„o..: 06/12/91  Ultima Altera‡„o..: 14/02/92             **
****************************************************************************
param nomarq
if pcount()<1
   ? "Erro: Falta Nome do Arquivo de Figuras"
   ?
   quit
endif
if at(".",nomarq)=0
   nomarq=nomarq+".FIG"
endif
if ! file(nomarq)
   ? "Erro: Arquivo [ &nomarq ] n„o Existe"
   ?
   quit
endif
setcancel(.f.)
modograf(6)
continua=.t.
titulo="MC3ETQ v1.0 - Gerador de Etiquetas Graficas - (C) 1991 - MC3 Informatica"
escreve(1,centra(titulo),titulo,1)
arqetq=" "
store "" to et_lin1,et_lin2,et_lin3,et_lin4,et_lin5
private lintxt[5]
afill(lintxt,"")
numcol=3
arq=fopen(nomarq,0)
buff=space(572)
tam=fseek(arq,0,2)
totfig=int(tam/572)
if rat("\",nomarq)#0
   nomarq=substr(nomarq,rat("\",nomarq)+1)
endif
linhah(6,0,639,1)
linhah(17,0,639,1)
quadrado(43,8,104,425,1)
for x = 1 to 5
 escreve(6+x,16,str(x,1)+chr(16),1)
 escreve(6+x,50,chr(17),1)
next
escreve(14,1,"Arquivo de Figuras......: "+upper(alltrim(nomarq)),1)
escreve(15,1,"Total de Figuras........: "+alltrim(str(totfig,4)),1)
escreve(16,1,"Arquivo de Etiqueta.....: "+upper(alltrim(arqetq)),1)
escreve(17,1,"Etiquetas por Linha.....: "+alltrim(str(numcol,1)),1)
linhah(188,0,639,1)
escreve(24,1,"["+CHR(26)+"] Proxima  ["+CHR(27)+"] Anterior  [HOME] Inicio  [END] Fim  [M] Movimenta  [ESC] Sai",1)
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
do while continua
 fseek(arq,0)
 for v = 1 to totfig
  if fread(arq,@buff,572) # 572
   modograf(3)
   ? "Erro: Houve Falha na Leitura do Arquivo"
   fclose(arq)
   quit
  endif
  escreve(4,1, "Figura No. "+alltrim(str(v,4))+space(4),1)
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
     tecla=inkey(0)
     do case
     case tecla=287
       bsave("tela")
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
             if type("et_arqf")#"C"
                et_arqf=nomarq
             endif
             if (et_arqf#nomarq).and.file(et_arqf)
                fclose(arq)
                nomarq=et_arqf
                arq=fopen(et_arqf,0)
                tam=fseek(arq,0,2)
                totfig=int(tam/572)
                escreve(14,1,"Arquivo de Figuras......: "+upper(nomarq)+space(5),1)
                escreve(15,1,"Total de Figuras........: "+alltrim(str(totfig,4))+space(4),1)
             endif
             if et_figr > totfig
                et_figr=totfig
             endif
             fseek(arq,(572*(et_figr-1)),0)
             v=et_figr-1
             numcol=et_colu
             escreve(16,1,"Arquivo de Etiqueta.....: "+upper(arqetq),1)
             escreve(17,1,"Etiquetas por Linha.....: "+alltrim(str(numcol,1)),1)
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
             save to &arqetq all like et_*
             escreve(16,1,"Arquivo de Etiqueta.....: "+upper(arqetq),1)
          endif
          escreve(21,1,space(50),1)
          escreve(22,1,space(13),1)
       ********************
       ** Imprime Etiquetas
       elseif opc=5
          escreve(21,1,"Quantidade de Etiquetas: [      ]",1)
          altlin=val(edita(21,28,4,"9"))
          if altlin#0
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
          escreve(21,1,space(39),1)
          escreve(22,1,space(30),1)
       *********************************************
       ** Imprime Todas as Figuras do Arquivo (.fig)
       elseif opc=6
          escreve(21,1,"Aperte uma tecla para iniciar... [ESC] Interrompe",1)
          IF INKEY(0)#27
            PRIVATE BUF1,BUF2,BUF3,BUF4,BUF5,CAT,CTT,CTL,CTF
            store repl(chr(0),616) to buf1,buf2,buf3,buf4,buf5
            LUGAR=FSEEK(ARQ,0,1)
            FSEEK(ARQ,0)
            CTL=7
            CTF=0
            set console off
            set print on
            IF TOTFIG<5
               ?
               imprime(CI(15)+CHR(14)+CI("LN")+SPACE(10))
               imprime("MC3ETQ v1.0 - Gerador de Etiquetas Graficas")
               ?
               imprime(CHR(14)+SPACE(19)+"Arquivo: "+NOMARQ+CI("DN")+CHR(18))
               ?
               ?
               IMPMENOR(TOTFIG)
            ELSE
              FOR CTT = 1 TO INT(TOTFIG/5)
                TNUM=CI(15)+SPACE(11)
                IF CTL = 7
                  ?
                  imprime(CI(15)+CHR(14)+CI("LN")+SPACE(10))
                  imprime("MC3ETQ v1.0 - Gerador de Etiquetas Graficas")
                  ?
                  imprime(CHR(14)+SPACE(19)+"Arquivo: "+NOMARQ+CI("DN")+CHR(18))
                  ?
                  ?
                   CTL=0
                ENDIF
                escreve(22,1,"Processando.....",1)
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF1)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF2)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF3)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF4)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(11)
 
                FREAD(ARQ,@BUFF,572)
                buft=buff+repl(chr(0),44)
                T2I(BUFt,@BUF5)
                ctf=ctf+1
                det=ltrim(str(ctf,4))
                TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(11)
 
                escreve(22,1,"Imprimindo .....",1)
                IMPCAT(BUF1,BUF2,BUF3,BUF4,BUF5,5)
                IF INKEY()=27
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
              IF TOTFIG%5 # 0 .AND. LASTKEY()#27
                IF CTL = 7
                  ?
                  imprime(CI(15)+CHR(14)+CI("LN")+SPACE(10))
                  imprime("MC3ETQ v1.0 - Gerador de Etiquetas Graficas")
                  ?
                  imprime(CHR(14)+SPACE(19)+"Arquivo: "+NOMARQ+CI("DN")+CHR(18))
                  ?
                  ?
                  CTL=0
                ENDIF
                IMPMENOR(TOTFIG-CTF)
              ENDIF
            ENDIF
            set console on
            set print off
            FSEEK(ARQ,LUGAR)
          ENDIF
          escreve(21,1,space(50),1)
          escreve(22,1,space(30),1)
       ***********************************
       ** Muda o Arquivo de Figuras (.fig)
       elseif opc=7
          escreve(21,1,"Digite o Nome do Arquivo: [          ]",1)
          oldarq=nomarq
          nomarq=alltrim(edita(21,29,8,"!A9"))
          nomarq=nomarq+".FIG"+space(8-Len(nomarq))
          if file(trim(nomarq))
             escreve(22,1,"Lendo o Arquivo...",1)
             fclose(arq)
             arq=fopen(nomarq,0)
             tam=fseek(arq,0,2)
             totfig=int(tam/572)
             et_figr=1
             fseek(arq,(572*(et_figr-1)),0)
             v=et_figr-1
             escreve(14,1,"Arquivo de Figuras......: "+upper(nomarq)+space(5),1)
             escreve(15,1,"Total de Figuras........: "+alltrim(str(totfig,4))+space(4),1)
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
       ** Configura o Numero de Colunas de Etiquetas
       elseif opc=8
          escreve(21,1,"No. de Etiquetas por Linha (1-4): [   ]",1)
          altlin=edita(21,37,1,"9")
          if val(altlin)>0 .and. val(altlin)<5
             numcol=val(altlin)
             escreve(21,1,space(39),1)
             escreve(17,1,"Etiquetas por Linha.....: "+alltrim(str(numcol,1)),1)
          else
             escreve(22,1,"Numero Invalido !! Tecle [ENTER]",1)
             do while inkey()#13
             enddo
             escreve(21,1,space(39),1)
             escreve(22,1,space(33),1)
          endif
       endif
     case tecla=1 && [home] - Primeira Figura
       v=totfig
       exit
     case tecla=6 && [end]  - Ultima Figura
         fseek(arq,(572*(totfig-1)),0)
         v=totfig-1
         exit
     case tecla=19 && <- Volta uma Figura
      if v = 1  
         fseek(arq,(572*(totfig-1)),0)
         v=totfig-1
         exit
      elseif v=2
         v=totfig
         exit
      else
        fseek(arq,-(572*2),1)
        v=v-2
        exit
      endif
     case tecla=4 && -> Avanca uma Figura
       exit
     case upper(chr(tecla))="M"
       escreve(21,1,"Movimenta para Figura No.: [      ]",1)
       cnum=edita(21,30,4,"9")
       escreve(21,1,space(70),1)
       vaifig=val(cnum)
       if vaifig > totfig
          vaifig=totfig
       endif
       if vaifig < 1
          vaifig=1
       endif
       fseek(arq,(572*(vaifig-1)),0)
       v=vaifig-1
       exit
     endcase
  enddo 
 next
enddo
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
TNUM=CI(15)+SPACE(11)
CTL=0
escreve(22,1,"Processando.....",1)
FREAD(ARQ,@BUFF,572)
buft=buff+repl(chr(0),44)
T2I(BUFt,@BUF1)
ctf=ctf+1
det=ltrim(str(ctf,4))
TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
IF NCOLU>=2
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF2)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
ENDIF
IF NCOLU>=3
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF3)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
ENDIF
IF NCOLU>=4
   FREAD(ARQ,@BUFF,572)
   buft=buff+repl(chr(0),44)
   T2I(BUFt,@BUF4)
   ctf=ctf+1
   det=ltrim(str(ctf,4))
   TNUM=TNUM+"   No. "+det+space(4-len(det))+SPACE(12)
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
  LN=SPACE(12)
  FOR T=1 TO NETQ
    imprime(CHR(27)+'L'+CHR(88)+CHR(0)+substr(BUFP,(j*88)-87,88))
    IF J>0.AND.J<5
     LN=LN+IF(LEN(LINHA[j])>30,LEFT(LINHA[j],30),LINHA[j]+SPACE(30-LEN(LINHA[j])))
    ELSEIF J=6
     LN=LN+IF(LEN(LINHA[5])>30,LEFT(LINHA[5],30),LINHA[5]+SPACE(30-LEN(LINHA[5])))
    ELSE
     LN=SPACE(30)
    ENDIF
    LN=LN+SPACE(22)
    imprime(SPACE(27))
  NEXT    
  IF (J*2)<10
     DESLOC=(J*2)*3
     imprime(CHR(13)+CHR(27)+"J"+CHR(DESLOC))   && RETORNO DO CARRO E AVANCO
     imprime(CI(15)+CI("LN")+LN+CHR(18)+CI("DN"))
  ELSEIF (J*2)=12
     DESLOC=6
     imprime(CHR(13)+CHR(27)+"J"+CHR(DESLOC))   && RETORNO DO CARRO E AVANCO
     imprime(CI(15)+CI("LN")+LN+CHR(18)+CI("DN"))
  ELSE
     DESLOC=0
  ENDIF
NEXT
?
?
RETURN(.T.)

***************
FUNCTION IMPCAT
***************
PARAMETERS BUF1,BUF2,BUF3,BUF4,BUF5,NCOL
PRIVATE J,T,BUFF
************* ROTINA DE IMPRESSAO *************
FOR J=1 TO 7
  imprime(CHR(13)+CHR(27)+"J"+CHR(24)+SPACE(8))
  LN=SPACE(12)
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
    imprime(SPACE(8))
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
   elseif dignum>=32.and.dignum<=47.and."X"$upper(pic)
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