/*********************************************************************
* ARQUIVO...: ZapDisk.OBJ                                            *
* PROGRAMA..: Biblioteca de fun‡oes em C para o Clipper 5.01         *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 30 de Junho de 1991                                    *
* ALTERACAO.: 16 de Julho de 1992                                    *
************************ FUN€ŽO DEFINIDA *****************************
*                                                                    *
* ZAPDISK().: Apaga todos os arquivos de um disco.                   *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <stdlib.h>
#include <dir.h>
#include <dos.h>

#define FCB_TAM 37
#define DELETE 0x13

CLIPPER zapdisk()
{
char *p_fcb, fcb[FCB_TAM];
union REGS regent,regsai;
struct SREGS seg;
int i,drv,drv_cor;
if (PCOUNT!=1 || !ISNUM(1))
   {
    _retni(1);
    return;
   }

drv_cor = getdisk();
drv=_parni(1)-1;
if ( drv<0 || drv>1 )
   {
    _retni(2);
    return;
   }
memset(fcb,0,FCB_TAM);
for ( i = 1 ; i <= 11 ; i++ )
    fcb[i]='*';
p_fcb = fcb;
setdisk(drv);
regent.h.ah = DELETE;
regent.x.dx = FP_OFF(p_fcb);
seg.ds      = FP_SEG(p_fcb);
intdosx(&regent,&regsai,&seg);
setdisk(drv_cor);
if ( regsai.h.al != 0 )
   {
    _retni(3);
    return;
   }
_retni(0);
return;
}
/* eof */
