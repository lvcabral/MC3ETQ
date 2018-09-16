/*********************************************************************
* ARQUIVO...: Teclaesp.OBJ                                           *
* PROGRAMA..: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 14 de Abril de 1991                                    *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Teclaesp(): Determina se uma tecla especial est  ligada.           *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS cpl;

CLIPPER teclaesp()
{
 cpl.h.ah = 2;
 int86(0x16, &cpl, &cpl);
 _retni(cpl.h.al);
 return;
}
