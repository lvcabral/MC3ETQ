/********************************************************************
* ARQUIVO..: StrInv.c                                               *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 19 de Dezembro de 1991                                 *
* ALTERACAO: 08 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* StrInv...: Inverte os Caracteres de uma Cadeia                    *
*                                                                   *
********************************************************************/

#include <clipper5.h>
static unsigned char *str1,*str2,*aux;
CLIPPER StrInv()
{
  unsigned int t,tam;
  tam=_parclen(1);
  str2=_xalloc(tam);
  if(str2==NULL)
    {
      _retl(FALSE);
      return;
    }
  str1=_parc(1);
  aux=str2;
  for(t=1;t<=tam;t++)
  {
   *str2=255-*str1;
   str1++;
   str2++;
   }
  _storclen(aux,tam,1);
  _xfree(aux);
  _retl(TRUE);
  return;
}