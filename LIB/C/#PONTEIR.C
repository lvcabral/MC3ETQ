/********************************************************************
* ARQUIVO..: PONTEIRO.C                                             *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 16 de Maio de 1992                                     *
* ALTERACAO: 08 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* PONTEIRO(): Retorna o ponteiro para uma cadeia de caracteres      *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <dos.h>
CLIPPER ponteiro()
{
  byte *string;
  string=_parc(1);
  _retni(FP_OFF(string));
  return;
}

