/********************************************************************
* ARQUIVO..: Converte.OBJ                                           *
* PROGRAMA.: Funáao em C para o Clipper v5.2                        *
* AUTORES..: Carlos Augusto P. Gomes e Antonio Carlos Barbosa.      *
* FONTE....: "CLIPPER COM C " Editora êrica                         *
* ADAPTAÄAO: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 14 de Outubro de 1990                                  *
* ALTERAÄéO: 21 de Fevereiro de 1992                                *
*********************** FUNÄéO DEFINIDA *****************************
*                                                                   *
* CONVERTE.: Converte em um Texto na Mem¢ria acentos e codigos espe-*
*            ciais de ImpressÑo                                     *
********************************************************************/

#include <stdio.h>
#include <extend.api>

extern unsigned    int aloca_mem();
extern     void    traduz();
static unsigned   char    *c_str, *c_str1;

static int tot_ele=0,t_str=0;

CLIPPER converte()
{
   unsigned  tot_memory=0,tot_ele2=0;
   c_str=_parc(3);
   t_str=_parclen(3);
   tot_ele=_parinfa(1,0);
   tot_ele2=_parinfa(2,0);
   if (tot_ele != tot_ele2)
    {
     _retl(FALSE);
     return;
    }
   tot_memory=aloca_mem();
   c_str1=_xalloc(tot_memory);
   if(c_str1==NULL)
     {
      _retl(FALSE);
      return;
     }
   memset(c_str1,0,tot_memory);
   traduz();
   _storclen(c_str1,tot_memory,3);
   _retl(TRUE);
   _xfree(c_str1);
   return;
}
unsigned int aloca_mem()
{
   register int  i=0,achou=FALSE;
   unsigned int  conta=0,ctc;
   unsigned char *ch;
   ch=c_str;
   for(ctc=1;ctc<=t_str;ctc++)
   {
    if(*ch>127)
    {
      for (i=1;i<=tot_ele;i++)
      {
       if(*ch==_parni(1,i))
       {
	  conta+=_parclen(2,i);
	  achou=TRUE;
	  break;
       }
      }
    }
    if(achou)
    {
      achou=FALSE;
    }
    else
    {
      conta++;
    }
    ch++;
   }
   return (conta);
}
void traduz()
{
   register int  i=0,idx;
   unsigned char *ch,*ch1,*blc;
   unsigned int ctc,vrf,btm;
   ch=c_str;
   ch1=c_str1;
   for(ctc=1;ctc<=t_str;ctc++)
   {
    if(*ch>127)
    {
      vrf=0;
      for(i=1;i<=tot_ele;i++)
      {
	if(*ch==_parni(1,i))
	{
	  blc=_parc(2,i);
	  btm=_parclen(2,i);
	  for(idx=1;idx<=btm;idx++)
	  {
	   *ch1=*blc;
	   ch1++;
	   blc++;
	  }
	  vrf=1;
	  break;
	}
      }
      if (vrf==0)
	{
	 *ch1++=*ch++;
	}
      else
	{
	 ch++;
	}
    }
    else
    {
      *ch1++=*ch++;
    }
   }
}




