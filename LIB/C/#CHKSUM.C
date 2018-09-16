/********************************************************************
* ARQUIVO..: CheckSum.c                                             *
* PROGRAMA.: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 18 de Dezembro de 1991                                 *
* ALTERA€ŽO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* CheckSum.: Retorna o somat¢rio de uma String de caracteres        *
*                                                                   *
********************************************************************/

#include <clipper5.h>

static unsigned char *buff;

CLIPPER checksum()
{
   unsigned long soma=0;
   unsigned int t;
   buff=_parc(1);
   for(t=1;t<=_parclen(1);t++)
   {
    soma+=buff[t-1];
   }
   _retnl(soma);
   return;
}



