/********************************************************************
* ARQUIVO..: T2I.c                                                  *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 21 de Dezembro de 1991                                 *
* ALTERACAO: 07 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* T2I .....: Transforma uma Figura da Tela para Impressora          *
*                                                                   *
********************************************************************/
#include <clipper5.h>

CLIPPER t2i()
{
   quant i;
   quant j;
   quant t;
   quant n;
   quant c;
   unsigned char *bf, *sai, *ap1, *string;
   unsigned int nca,ag[]={128,64,32,16,8,4,2,1},aux[8];
   ap1=_parc(1);
   sai=_xalloc(_parclen(2));
   string=sai;
   for(i=0;i<=615;i+=88)
      {
       for(j=0;j<=10;j++)
	  {
	   aux[0]=0;
	   aux[1]=0;
	   aux[2]=0;
	   aux[3]=0;
	   aux[4]=0;
	   aux[5]=0;
	   aux[6]=0;
	   aux[7]=0;
	   nca=0;
	   for(t=i;t<=i+87;t+=11)
	      {
	       bf=ap1;
	       bf+=(t+j);
	       c=*bf;
	       if(c>=128)
		 { aux[0]+=ag[nca];
		   c-=128;}
	       if(c>=64)
		 { aux[1]+=ag[nca];
		   c-=64;}
	       if(c>=32)
		 { aux[2]+=ag[nca];
		   c-=32;}
	       if(c>=16)
		 { aux[3]+=ag[nca];
		   c-=16;}
	       if(c>=8)
		 { aux[4]+=ag[nca];
		   c-=8;}
	       if(c>=4)
		 { aux[5]+=ag[nca];
		   c-=4;}
	       if(c>=2)
		 { aux[6]+=ag[nca];
		   c-=2;}
	       if(c>=1)
		 { aux[7]+=ag[nca];
		   c-=1;}
	      nca++;
	      }
	    for(n=0;n<=7;n++)
	     {
	      *sai=aux[n];
	      sai++;
	     }
	  }
      }
  _storclen(string,_parclen(2),2);
  _xfree(string);
  _ret();
  return;
}



