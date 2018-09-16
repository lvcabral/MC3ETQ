function fsum
param nomarq
private arq,tam,sum
if ! file(nomarq)
   return(-1)
endif
arq=fopen(nomarq)
if ferror()#0
   return(ferror()*-1)
endif   
tam=fseek(arq,0,2)
if ferror()#0
   return(ferror()*-1)
endif   
if tam>64000
   tam=64000
endif
fseek(arq,0)
sum=checksum(freadstr(arq,tam))
if ferror()#0
   return(ferror()*-1)
else
   return(sum)   
endif   
