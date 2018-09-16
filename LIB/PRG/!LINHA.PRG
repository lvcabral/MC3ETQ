**************
function linha
**************
param l1,c1,l2,c2,cor
private l,c,passo
if c1=c2
   if l1<l2
     linhav(c1,l1,l2,cor)
   else  
     linhav(c2,l2,l1,cor)
   endif  
elseif l1=l2
   if c1<c2
     linhah(l1,c1,c2,cor)
   else  
     linhah(l2,c2,c1,cor)
   endif  
else   
   m=(l2-l1)/(c2-c1)
   passo=if(abs(m)<1,1,1/abs(m))
   if c1<c2
     for c = c1 to c2 step passo
        l=m*(c-c1)+l1
        ponto(l,c,cor)
     next
   else  
     for c = c2 to c1 step passo
        l=m*(c-c2)+l2
        ponto(l,c,cor)
     next
   endif  
endif
return(.t.)   
