function VTOA
if ! used()
   return(.f.)
endif
private campos[fcount()],t,var,aux
afields(campos)
for t=1 to len(campos)
   aux=campos[t]
   var=strtran(aux,"_","X",1,1)
   replace &aux with M->&var
next
return(.t.)
