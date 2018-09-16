function dv10
param valor
private buf,t,tam,parcela
tam=len(valor)
buf=0
for t = 0 to tam-1
    parcela=0
    parcela=val(substr(valor,tam-t,1))*if(par(t+1),1,2)
    buf = buf + if(parcela>9,parcela-9,parcela)
next    
if buf=0
   return(0)
endif
resto=buf%10
return(if(resto=0,0,10-resto))