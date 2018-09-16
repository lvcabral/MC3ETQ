FUNCTION FBackup
PARAM Arqs,NDrv,BLin,BCol,BCorM,BCorT,BCorE
PRIVATE NArqs,NDsk,NTrab1,NTrab2,NTrab3,CArq,V,T,;
        OldColor,OldScreen,OldCursor,OldLin,OldCol,Espaco,Flag
IF PCOUNT() < 2
   RETURN(.f.)
ENDIF
NArqs=ADIR(Arqs) 
IF NArqs < 1
   RETURN(.f.)
ENDIF
IF TYPE("BLin") # "N"
   BLin = 10
ENDIF
IF TYPE("BCol") # "N"
   BCol = 21
ENDIF
IF NDrv = 1
   Drive = "A:"
ELSEIF NDrv =2
   Drive = "B:"
ELSE
   RETURN(.f.)
ENDIF
IF TYPE("BCORM")#"C"
   BCorM="W+/B"
ENDIF
IF TYPE("BCORT")#"C"
   BCorT="GR+/B"
ENDIF
IF TYPE("BCORE")#"C"
   BCorE="W+*/R"
ENDIF
PRIVATE Arquivo[NArqs],Tamanho[NArqs]
ADIR(Arqs,Arquivo,Tamanho)
NDsk=0
OldColor=SETCOLOR()
OldScreen=SAVESCREEN(BLin,BCol,BLin+3,BCol+37)
OldCursor=SetCursor()
OldLin=ROW()
OldCol=COL()
Flag=.t.
IF __NewDisk() # 0 
   SETCOLOR(OldColor)
   RESTSCREEN(BLin,BCol,BLin+3,BCol+37,OldScreen)
   SETCURSOR(OldCursor)
   @ OldLin,OldCol SAY ""
   Return(.f.)
ENDIF
FOR V = 1 TO NArqs
    IF (Tamanho[V]+22) <= Espaco
       SETCOLOR(BCorT)
       SCROLL(BLin+1,BCol+1,BLin+2,BCol+36,0)
       @ BLin+1,BCol+1 SAY " Gerando Disco Backup N§ "+STRZERO(Ndsk,3)+"   "
       @ BLin+2,BCol+1 SAY " ARQUIVO -> "+DRIVE+ARQUIVO[V]+SPACE(12-LEN(ARQUIVO[V]))
       IF Flag
          NTrab1=FOPEN(Arquivo[V],0)
       ENDIF
       IF Tamanho[V] <= 20000
          Buff=SPACE(Tamanho[V])
          FREAD(NTrab1,@Buff,Tamanho[V])
          FWRITE(NTrab2,Buff)
       ELSE
          FOR T = 1 TO INT(TAMANHO[V] / 20000)
              Buff=SPACE(20000)
              FREAD(NTrab1,@Buff,20000)
              FWRITE(NTrab2,Buff)
          NEXT
          Buff=SPACE(Tamanho[V]-(INT(Tamanho[V]/20000)*20000))
          IF LEN(BUFF)>0
             FREAD(NTrab1,@Buff,LEN(Buff))
             FWRITE(NTrab2,Buff)
          ENDIF
       ENDIF
       Buff=Arquivo[V]+SPACE(12-LEN(Arquivo[V]))+STR(Tamanho[V],8)+CHR(13)+CHR(10)
       IF V=NARQS
          IF AT(".",BUFF)>0
             BUFF=STRTRAN(BUFF,".",">",1,1)
          ELSE
             BUFF=STRTRAN(BUFF," ",">",1,1)
          ENDIF
       ENDIF
       FWRITE(NTrab3,Buff)
       Espaco=Espaco-(Tamanho[V]-22)
       Flag=.t.
       FCLOSE(NTrab1)
    ELSEIF Espaco <= 1024
       FCLOSE(NTrab2)
       FCLOSE(NTrab3)
       IF __NewDisk() # 0 
          EXIT
       ENDIF
       V=V-1
    ELSE
       SETCOLOR(BCorT)
       SCROLL(BLin+1,BCol+1,BLin+2,BCol+36,0)
       @ BLin+1,BCol+1 SAY " Gerando Disco Backup N§ "+STRZERO(Ndsk,3)+"   "
       @ BLin+2,BCol+1 SAY " ARQUIVO -> "+DRIVE+ARQUIVO[V]+SPACE(12-LEN(ARQUIVO[V]))
       IF Flag
          NTrab1=FOPEN(Arquivo[V],0)
       ENDIF
       IF Espaco <= 20000
          Buff=SPACE(Espaco-22)
          FREAD(NTrab1,@Buff,(Espaco-22))
          FWRITE(NTrab2,Buff)
          Buff=Arquivo[V]+SPACE(12-LEN(Arquivo[V]))+STR((Espaco-22),8)+CHR(13)+CHR(10)
          FWRITE(NTrab3,Buff)
          FCLOSE(NTrab2)
          FCLOSE(NTrab3)
          Tamanho[V]=Tamanho[V]-(Espaco-22)
          IF __NewDisk() # 0 
             FCLOSE(NTrab1)
             EXIT
          ENDIF
          Flag=.f.
          V=V-1
       ELSE       
          FOR T = 1 TO INT((Espaco-22) / 20000)
              Buff=SPACE(20000)
              FREAD(NTrab1,@Buff,20000)
              FWRITE(NTrab2,Buff)
          NEXT
          Buff=SPACE((Espaco-22)-(INT((Espaco-22)/20000)*20000))
          IF LEN(BUFF)>0
             FREAD(NTrab1,@Buff,LEN(Buff))
             FWRITE(NTrab2,Buff)
          ENDIF
          Buff=Arquivo[V]+SPACE(12-LEN(Arquivo[V]))+STR((Espaco-22),8)+CHR(13)+CHR(10)
          FWRITE(NTrab3,Buff)
          FCLOSE(NTrab2)
          FCLOSE(NTrab3)
          Tamanho[V]=Tamanho[V]-(Espaco-22)
          IF __NewDisk() # 0 
             FCLOSE(NTrab1)
             EXIT
          ENDIF
          V=V-1
          Flag=.f.
       ENDIF
    ENDIF
NEXT
FCLOSE(NTrab2)
FCLOSE(NTrab3)
SETCOLOR(OldColor)
RESTSCREEN(BLin,BCol,BLin+3,BCol+37,OldScreen)
SETCURSOR(OldCursor)
@ OldLin,OldCol SAY ""
RETURN(.t.)
******************    
FUNCTION __NewDisk

SETCOLOR(BCorM)
@ BLin,BCol CLEAR TO BLin+2,BCol+37
JANELA( BLin,BCol,BLin+3,BCol+37 )
NDsk=NDsk+1
DO WHILE .T.
  SETCOLOR(BCorT)
  SCROLL(BLin+1,BCol+1,BLin+2,BCol+36,0)
  @ BLin+1,BCol+1 SAY " Insira o Disco N§ "+STRZERO(NDsk,3)+" no Drive "+DRIVE
  @ BLin+2,BCol+1 SAY " Aperte uma tecla para Continuar..."
  CLEAR TYPEAHEAD
  IF INKEY(0)=27
    RETURN(1)
  ENDIF
  IF TSTDRV(Drive,3) # 0
     SETCOLOR(BCorE)
     TONE(300,3)
     @ BLin+1,BCol+1 SAY " Erro: No Disco ou Drive Aberto !!! "
     INKEY(0)
     LOOP
  ELSE
     IF ADIR(Drive+"*.*") # 0
        IF ZAPDISK(NDRV) # 0
           SETCOLOR(BCorE)
           TONE(300,3)
           @ BLin+1,BCol+1 SAY " Erro: Prote‡„o Contra Grava‡„o !!! "
           INKEY(0)
           LOOP
        ENDIF
     ENDIF
     EXIT
  ENDIF
ENDDO
NTrab2=FCREATE(Drive+"BACKUP."+STRZERO(NDsk,3),0)
NTrab3=FCREATE(Drive+"DIR."+STRZERO(NDsk,3),0)
Espaco=Diskspace(NDrv)-1650
RETURN(0)
*****************************>> FIM DO ARQUIVO <<***************************** 
