S/*********************************************************************
* ARQUIVO...: Modograf.OBJ                                           *
* PROGRAMA..: Fun‡ao em C para o Clipper Summer'87                   *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 12 de Abril de 1991                                    *
* ALTERA€AO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* MODOGRAF(): Muda/Retorna o Modo Gr fico do Monitor de V¡deo.       *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS r;
extern unsigned int _modograf();
CLIPPER modograf()
{
 if (PCOUNT>0)
 {
   r.h.al =(char) _parni(1);
   r.h.ah = 0;
   int86(0x10, &r, &r);
   _retni(r.h.al);
 }
 else
 {
  _retni(_modograf());
 }
 return;
}
unsigned int _modograf(void)
{
 r.h.ah = 0x0F;
 int86(0x10, &r, &r);
 return(r.h.al);
}
