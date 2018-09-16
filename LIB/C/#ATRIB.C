/*********************************************************************
* ARQUIVO...: Atributo.OBJ                                           *
* PROGRAMA..: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 15 de Maio de 1992                                     *
* ALTERA€ŽO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Atributo(): Altera o atributo de um arquivo/diretorio.             *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS atrb;
static struct SREGS sregs;
CLIPPER atributo()
{
 if( PCOUNT < 2 || !ISCHAR(1) || !ISNUM(2) )
   {
     _retl(FALSE);
     return;
   }
 if( _parni(2) >= 8 && _parni(2) < 0x20 )
   {
    _retl(FALSE);
    return;
   }
 segread(&sregs);
 sregs.ds  = FP_SEG(_parc(1));
 atrb.x.dx = FP_OFF(_parc(1));
 atrb.x.cx = _parni(2);
 atrb.h.al = 1;
 atrb.h.ah = 0x43;
 intdosx(&atrb, &atrb, &sregs);
 if(atrb.x.ax==514)
   _retl(TRUE);
 else
   _retl(FALSE);
 return;
}
