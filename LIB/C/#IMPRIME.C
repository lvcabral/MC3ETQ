/********************************************************************
* ARQUIVO..: IMPRIME.C                                              *
* PROGRAMA.: Fun‡ao em C para o Clipper Summer'87                   *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 21 de Dezembro de 1991                                 *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* IMPRIME..: Envia uma string p/ impressora.                        *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <dos.h>
CLIPPER imprime()
{
  quant a;
  byte *buff;
  buff=_parc(1);
  for(a=0;a<=(_parclen(1)-1);a++)
  {
   bota_fora(buff[a]);
  }
  _ret();
  return;
}
bota_fora(carac)
byte carac;
{
  union REGS regs;
  regs.h.ah=0;
  regs.h.al=carac;
  regs.x.dx=0;
  int86(0x17,&regs,&regs);
  return(regs.h.ah);
}

