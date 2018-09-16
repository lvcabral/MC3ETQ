/*********************************************************************
* ARQUIVO...: MaxCol.OBJ                                             *
* PROGRAMA..: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 15 de julho de 1992                                    *
* ALTERA€AO.:                                                        *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* MAX_COL().: Retorna o numero maximo de colunas do Monitor          *
*                                                                    *
*********************************************************************/

#include <dos.h>

static union REGS r;
unsigned int max_col(void)
{
 r.h.ah = 0x0F;
 int86(0x10, &r, &r);
 return(r.h.ah-1);
}
