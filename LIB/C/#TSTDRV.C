/*********************************************************************
* ARQUIVO...: TstDrv.OBJ                                             *
* PROGRAMA..: Biblioteca de fun‡oes em C para o Clipper 5.01         *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 14 de Setembro de 1991                                 *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€ŽO DEFINIDA *****************************
*                                                                    *
* TSTDRV()..: Testa a condicao atual de um drive.                    *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <ctype.h>
#include <dos.h>

#define TESTA 0x13

CLIPPER tstdrv()
{
   union REGS tdrv;
   int i,v;
   tdrv.h.dl=toupper(*_parc(1))-65;
   if (tdrv.h.dl < 0)
   {
    _retni(30);
    return;
   }
   if (PCOUNT<2)
      v=1;
   else
      v=_parni(2);
   for (i=1;i<=v;i++)
   {
    tdrv.h.ah = 4 ;   /*  fun‡ao de verifica‡ao */
    tdrv.h.dh = 0 ;   /*  n§ da cabe‡a          */
    tdrv.h.ch = 10;   /*  n§ da trilha          */
    tdrv.h.cl = 5 ;   /*  n§ do setor           */
    tdrv.h.al = 1 ;   /*  n§ de setores a ler   */
    int86(TESTA,&tdrv,&tdrv);
   }
   _retni(tdrv.h.ah);
   return;
}
/* eof */