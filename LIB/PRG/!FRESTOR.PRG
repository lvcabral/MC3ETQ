FUNCTION FRestore
PARAM NDrv,NWay,BLin,BCol,BCorM,BCorT,BCorE
PRIVATE NArqs,NDsk,NTrab1,NTrab2,NTrab3,CArq,V,T,OldLin,OldCol,;
        OldColor,OldScreen,OldCursor,Espaco,Flag,FNom,Ftam
IF PCOUNT() < 2
   RETURN(.f.)
ENDIF
IF TYPE("BLIN") # "N"
   BLin = 10
ENDIF
IF TYPE("BCOL") # "N"
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
SAIDA=CHR(64+NWay)+":"
IF SAIDA=DRIVE
   RETURN(.F.)
ENDIF
NDsk=0
OldColor=SETCOLOR()
OldScreen=SAVESCREEN(BLin,BCol,BLin+3,BCol+37)
OldCursor=SetCursor()
OldLin=ROW()
OldCol=COL()
FNom=SPACE(12)
FTam=0
Flag=.t.
Continua=.t.
DO WHILE Continua
  IF __OldDisk() # 0 
     IF TYPE("NTRAB3") = "N"
        FCLOSE(NTrab3)
     ENDIF
     SETCOLOR(OldColor)
     RESTSCREEN(BLin,BCol,BLin+3,BCol+37,OldScreen)
     SETCURSOR(OldCursor)
     @ OldLin,OldCol SAY ""
     Return(.f.)
  ENDIF
  FOR V = 1 TO NArqs
    Buff=SPACE(12)
    FREAD(NTrab2,@Buff,12)
    IF AT(">",BUFF)#0
       Continua=.f.
       BUFF=STRTRAN(BUFF,">",".")
    ENDIF
    IF BUFF=FNOM
       Espaco=Espaco-FTam
       FLAG=.F.
    ELSE
       IF TYPE("NTRAB3") = "N"
          FCLOSE(NTrab3)
       ENDIF
       Espaco=DISKSPACE(NWay)
       FLAG=.t.
    ENDIF
    FNom=Buff
    Buff=SPACE(10)
    FREAD(NTrab2,@Buff,10)
    FTam=VAL(Left(Buff,8))
    IF FTam > Espaco
      @ BLin+2,BCol+1 SAY " Aperte uma tecla para Continuar..."
      __ERROU(" Erro: Disco Destino est  Cheio !!! ")
      FCLOSE(NTrab1)
      FCLOSE(NTrab2)   
      RETURN(.F.)
    ENDIF
    SETCOLOR(BCorT)
    SCROLL(BLin+1,BCol+1,BLin+2,BCol+36,0)
    @ BLin+1,BCol+1 SAY " Restaurando Disco Backup N§ "+STRZERO(Ndsk,3)
    @ BLin+2,BCol+1 SAY " ARQUIVO -> "+SAIDA+FNOM
    IF Flag
       NTrab3=FCREATE(Saida+FNom,0)
    ENDIF
    IF FTam <= 20000
       Buff=SPACE(FTam)
       FREAD(NTrab1,@Buff,FTam)
       FWRITE(NTrab3,Buff)
    ELSE
       FOR T = 1 TO INT(FTAM / 20000)
         Buff=SPACE(20000)
         FREAD(NTrab1,@Buff,20000)
         FWRITE(NTrab3,Buff)
       NEXT
       Buff=SPACE(FTam-(INT(FTam/20000)*20000))
       IF LEN(BUFF)>0
          FREAD(NTrab1,@Buff,LEN(Buff))
          FWRITE(NTrab3,Buff)
       ENDIF
    ENDIF
  NEXT
  FCLOSE(NTrab1)
  FCLOSE(NTrab2)
ENDDO
FCLOSE(NTrab3)
SETCOLOR(OldColor)
RESTSCREEN(BLin,BCol,BLin+3,BCol+37,OldScreen)
SETCURSOR(OldCursor)
@ OldLin,OldCol SAY ""
RETURN(.t.)
******************    
FUNCTION __OldDisk
PRIVATE Tam2
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
     __ERROU(" Erro: No Disco ou Drive Aberto !!! ")
     LOOP
  ELSEIF ADIR(Drive+"*.*") # 2
     __ERROU(" Erro: Este Disco n„o ‚ de Backup ! ")
     LOOP
  ELSEIF !FILE(DRIVE+"BACKUP."+STRZERO(NDSK,3)).OR.!FILE(DRIVE+"DIR."+STRZERO(NDSK,3))
     __ERROU(" Erro: Este Disco n„o ‚ o N§  "+STRZERO(NDSK,3)+" !!")
     LOOP
  ELSE
     NTrab1=FOPEN(Drive+"BACKUP."+STRZERO(NDsk,3),0)
     NTrab2=FOPEN(Drive+"DIR."+STRZERO(NDsk,3),0)
     TAM2=FSEEK(NTrab2,0,2)
     FSEEK(NTrab2,0)
     IF (Tam2%22) = 0
        NArqs=Tam2/22
     ELSE
        __ERROU(" Erro: Arq. Controle Adulterado !!! ")
        LOOP
     ENDIF
     EXIT
  ENDIF
ENDDO
RETURN(0)
************
FUNC __ERROU
PARAM MSG
SETCOLOR(BCorE)
TONE(300,3)
@ BLin+1,BCol+1 SAY MSG 
INKEY(0)
RETURN(.T.)
*****************************>> FIM DO ARQUIVO <<***************************** 
