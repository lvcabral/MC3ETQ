/********************************************************************
* ARQUIVO..: Data.OBJ                                               *
* PROGRAMA.: Fun‡ao em C para o Clipper Summer'87                   *
* AUTORES..: Luiz Antonio Quintela e M rio S‚rgio L. Pimentel       *
* FONTE....: "CLIPPER COM LINGUAGEM C" Editora Mc Graw Hill         *
* ADAPTA€AO: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 04 de Setembro de 1990                                 *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* DATA()...: Muda a Data do Sistema (Retorna .F. se Houver Erro)    *
*                                                                   *
********************************************************************/

#include <clipper5.h>
#include <dos.h>

CLIPPER data()
{
 char  data[9],
			 ano[5],
			 mes[3],
			 dia[3];

 union REGS r;

 if (PCOUNT != 1 || !ISDATE(1))
		{
		 _retl(0);
		 return;
		}
 strcpy(data,_pards(1));
 strcpy(ano,data,4);
 strcpy(mes,&data[4],2);
 strcpy(dia,&data[6],2);
 ano[4] = mes[2]= dia[2] = '\0';

 r.x.cx  = atoi(ano);
 r.h.dh  = atoi(mes);
 r.h.dl  = atoi(dia);
 r.h.ah  = 0x2B;

 if(  r.x.cx <1980 || r.x.cx  >2099 ||
			r.h.dh <1    || r.h.ch  >12   ||
			r.h.dl <1    || r.h.dl  >31    )
			{
			_retl(0);
			return;
			}
 intdos(&r,&r);

 if( r.h.al==0)
	 _retl(1);
 else
	 _retl(0);
 return;
}

/*eof*/

