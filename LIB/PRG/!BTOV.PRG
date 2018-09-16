function BTOV
if ! used()
   return(.f.)
endif
private campos[fcount()],tipos[fcount()],t,var,aux
afields(campos,tipos)
for t=1 to len(campos)
   aux=campos[t]
   var=strtran(aux,"_","X",1,1)
   public &var
   do case
   case tipos[t]="N"
     store 0 to &var
   case tipos[t]="C"
     store space(len(&aux)) to &var
   case tipos[t]="D"
     store ctod("  /  /  ") to &var
   case tipos[t]="L"
     store .f. to &var
   case tipos[t]="M"
     store "" to &var
   endcase    
next
return(.t.)
