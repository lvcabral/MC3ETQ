function ATOV
if ! used()
   return(.f.)
endif
private campos[fcount()],t,var,aux
afields(campos)
for t=1 to len(campos)
   aux=campos[t]
   var=strtran(aux,"_","X",1,1)
   public &var
   store &aux to &var
next
return(.t.)
