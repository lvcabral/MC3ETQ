FUNCTION EXPLODE
PARAMETERS R,C,R1,C1,TIPO
Private TELA_ANT,IR,IC,IR1,IC1,ODD
IF TYPE("TIPO")#"N"
   TIPO=0
ENDIF
R=INT(R)
R1=INT(R1)
C=INT(C)
C1=INT(C1)
TELA_ANT=SAVESCREEN(R,C,R1,C1)
IR=(R+R1)/2-1
IC=(C+C1)/2-1
IR1=IR+1
IC1=IC+1
ODD=.F.
DO WHILE .T.
   ODD=!ODD
   IF ODD
      IF (IR>R)
         IR=IR-1
         IF IR<R
            IR=R
         ENDIF
      ENDIF
      IF IR1<R1
         IR1=IR1+1
         IF IR1>R1
            IR1=R1
         ENDIF
      ENDIF
   ENDIF
   IF (IC>C)
      IC=IC-1
      IF IC<C
         IC=C
      ENDIF
   ENDIF
   IF IC1<C1
      IC1=IC1+1
      IF IC1>C1
         IC1=C1
      ENDIF
   ENDIF
   @ IR,IC CLEAR TO IR1,IC1
   DO CASE
   CASE TIPO=1
       @ IR,IC TO IR1,IC1
   CASE TIPO=2
       @ IR,IC TO IR1,IC1 DOUBLE
   CASE TIPO=3
       JANELA(IR,IC,IR1,IC1)
   CASE TIPO=4
       JANELA(IR,IC,IR1,IC1,2)
   ENDCASE
   IF IR=R .AND. IC=C .AND. IR1=R1 .AND. IC1=C1
      EXIT
   ENDIF
ENDDO
RETURN(TELA_ANT)
