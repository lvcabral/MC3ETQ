/********************************************************************
* ARQUIVO..: REBOOT.C                                               *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 16 de Maio de 1992                                     *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* REBOOT().: Reinicializa o Sistema.                                *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <dos.h>
CLIPPER reboot()
{
  union REGS regs;
  int86(0x19,&regs,&regs);
  _ret();
  return;
}

