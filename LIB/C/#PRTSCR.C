/********************************************************************
* ARQUIVO..: PRTSCR.C                                               *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 28 de Dezembro de 1991                                 *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* PRTSCR...: Imprime a tela. ( O mesmo que pressionar a tecla )     *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <dos.h>
CLIPPER prtscr()
{
  union REGS regs;
  int86(0x5,&regs,&regs);
  _ret();
  return;
}

