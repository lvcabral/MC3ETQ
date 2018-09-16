/********************************************************************
* ARQUIVO..: RestTela.c                                             *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 25 de Dezembro de 1991                                 *
* ALTERACAO: 06 de Junho de 1991                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* RestTela.: Restaura na Tela um Grafico preciamente Salvo.         *
*                                                                   *
********************************************************************/

#include <mem.h>
#include <dos.h>
#include <clipper5.h>

#define VIDEO    0xB800
#define DESLOC   0
#define TAMMAX   16192

static  char far *p;

CLIPPER RestTela()
{
   unsigned int k;
   if (_parclen(1) > TAMMAX)
      k=TAMMAX;
   else
      k=_parclen(1);
   p=_parc(1);
   movedata(FP_SEG(p),FP_OFF(p),VIDEO,DESLOC,k);
   _retl(TRUE);
   return;
}
