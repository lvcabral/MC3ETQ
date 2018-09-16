func dda
param data
if type("data")#"D"
   data=date()
endif
do case
case month(data)=1
     return(day(data))
case month(data)=2
     return(31+day(data))
case month(data)=3
     return(if(bissexto(data),60,59)+day(data))
case month(data)=4
     return(if(bissexto(data),91,90)+day(data))
case month(data)=5
     return(if(bissexto(data),121,120)+day(data))
case month(data)=6
     return(if(bissexto(data),152,151)+day(data))
case month(data)=7
     return(if(bissexto(data),182,181)+day(data))
case month(data)=8
     return(if(bissexto(data),213,212)+day(data))
case month(data)=9
     return(if(bissexto(data),244,243)+day(data))
case month(data)=10
     return(if(bissexto(data),274,273)+day(data))
case month(data)=11
     return(if(bissexto(data),305,304)+day(data))
other     
     return(if(bissexto(data),335,334)+day(data))
endcase
