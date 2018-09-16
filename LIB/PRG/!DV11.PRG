function dv11
param valor
private buf,t,tam,parcela,i
tam=len(valor)
buf=0
i=2
for t = 0 to tam-1
    parcela=0
    parcela=val(substr(valor,tam-t,1))*i
    buf = buf + parcela
    i=if(i=30,1,i+1)
next    
resto=buf%11
do case
case buf=0
   return(0)
case resto=0
   return(0)
case resto=1
   return(0)
other
   return(11-resto)
endcase   
