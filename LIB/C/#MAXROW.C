/*********************************************************************
* ARQUIVO...: MaxRow.OBJ                                             *
* PROGRAMA..: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 15 de julho de 1992                                    *
* ALTERA€AO.:                                                        *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* MAX_ROW().: Retorna o numero maximo de linha do Monitor            *
*                                                                    *
*********************************************************************/

#include <dos.h>
static union  REGS  inregs;
unsigned int max_row(void)
{
   inregs.h.ah = 0x11;
   inregs.h.al = 0x30;
   inregs.h.bh = 0;
   int86(0x10,&inregs,&inregs);
   return(inregs.h.dl);
}
