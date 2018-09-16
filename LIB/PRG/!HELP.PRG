FUNCTION Help
MEMVAR ArqHlp,NivHlp,CorHlp
PARAM HPrg,HLin,HVar
IF TYPE("HTELA")="C"
   return(.f.)
ENDIF
PRIVATE Ajuda,HTela,HCor,hcurs,hini,hfim,htxt,t,htit,hlin,hcol,caux,cpos,cfin
if Type("ARQHLP")#"C".or.Type("NIVHLP")#"N"
   return(.f.)
else
   if file(arqhlp)
      ajuda=memoread(arqhlp)
   else
      return(.f.)
   endif
endif
hini= at("{"+strzero(nivhlp,3)+"}",ajuda)
if hini = 0
   return(.f.)
endif
***************************************
* Rotina de selecao de nivel de ajuda *
***************************************
htit=memoline(ajuda,58,1)
If Type("CORHLP")#"C"
   CorHlp=memoline(ajuda,58,2)
Endif
ajuda=substr(ajuda,hini+7)
hfim=at("{",ajuda)
if hfim=0
   htxt=ajuda
else
   htxt=substr(ajuda,1,hfim-1)
endif
***************************************
hlin=row()
hcol=col()
hcor=setcolor()
hcurs=setcursor()
setcursor(0)
setcolor(CorHlp)
hCol1=INT((MAXCOL()-60)/2)
hCol2=hCol1+59
htela=savescreen(02,hCol1,MAXROW()-2,hCol2)
scroll(02,hCol1,MAXROW()-2,hCol2,0)
janela(02,hCol1,MAXROW()-2,hCol2)
@ 04,hCol1+1 to 04,hCol2-1
Caux=setcolor()
Cpos=at(",",caux)+1
Cfin=at(",",substr(caux,cpos+1))
Caux=substr(caux,cpos,cfin)
setcolor(Caux)
@ 03,hCol1+1 say htit
setcolor(CorHlp)
if mlcount(htxt,58)<MAXROW()-6
   keyb chr(27)
   memoedit(htxt,5,hCol1+1,MAXROW()-3,hCol2-1,.f.,,58)
   do while inkey()#27
   enddo
else
   memoedit(htxt,5,hCol1+1,MAXROW()-3,hCol2-1,.f.,,58)
endif
setcolor(hcor)
restscreen(2,hCol1,MAXROW()-2,hCol2,htela)
setcursor(hcurs)
@ hlin,hcol say ""
return(.t.)
