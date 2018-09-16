Function DVCB( num )

LOCAL tm:=len(num),t,vetor[len(num)]


For t = 1 to tm
   vetor[t]:=substr(num,t,1)
Next

tm=0

For t = 2 to len(num) step 2
   tm+=val(substr(num,t,1))
Next

tm*=3

For t = 1 to len(num)-1 step 2
   tm+=val(substr(num,t,1))
Next

dg:=tm+10

cn:=ltrim(str(dg))

If Len(cn)>2
   cn:=Left(cn,2)+"0"
Else
   cn:=Left(cn,1)+"0"
Endif

dg:=val(cn)
tm:=dg-tm

Return(if(tm==10,0,tm))
