/********************************************************************
* ARQUIVO..: SalvaTel.c                                             *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.2                         *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 25 de Dezembro de 1991                                 *
* ALTERACAO: 15 de Mar‡o de 1994                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* SalvaTela: Salva Tela Grafica em uma var. passada por referencia  *
*                                                                   *
********************************************************************/

#include <extend.api>
#include <mem.h>
#include <dos.h>

#define VIDEO    0xB800
#define DESLOC   0
#define TAMMAX   16192

static  char far *p;

CLIPPER salvatela()
{
   unsigned int k;
   if (_parclen(1)>TAMMAX)
      k=TAMMAX;
   else
      k=_parclen(1);
   p=_parc(1);
   movedata(VIDEO,DESLOC,FP_SEG(p),FP_OFF(p),k);
   _retl(TRUE);
   return;
}
