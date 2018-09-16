/********************************************************************
* ARQUIVO..: CorTela.c                                              *
* PROGRAMA.: Funáao em C para o Clipper v5.01                       *
* AUTORES..: Carlos Augusto P. Gomes e Antonio Carlos Barbosa       *
* FONTE....: "CLIPPER COM C" Editora êrica                          *
* ADAPTAÄAO: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 06 de Outubro de 1990                                  *
* ALTERACAO: 15 de Julho de 1992                                    *
*********************** FUNÄAO DEFINIDA *****************************
*                                                                   *
* COR_TELA.: Muda a Cor de Uma Parte Definida da Tela.              *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <dos.h>

#define MAXATRIB 20
#define MAXCOLUN (max_col()+1)
#define VIDEO 0xB800
static int    pos_data;
static char   far *p;
static char   area[264];
extern unsigned int max_col(void);
extern unsigned int max_row(void);
extern unsigned int atr_cor(char *);

CLIPPER cor_tela()
{
register i=0,j=0;
unsigned l=0,c=0,l1=0,c1=0,total=0;
unsigned char atr = 0x00;

if( PCOUNT < 5 || !ISNUM(1) || !ISNUM(2) || !ISNUM(3) || !ISNUM(4))
 {
  _retni(-1);
  return;
 }

l=_parni(1);
c=_parni(2);
l1=_parni(3);
c1=_parni(4);

if (l<0 || c<0 || l1>max_row() || c1>max_col() || (l1-l)<0 || (c1-c)<0)
	{
	   _retni(-2);
	   return;
	}
if (ISNUM(5))
   {
    atr=_parni(5);
   }
else if (ISCHAR(5) && _parclen(5)<(MAXATRIB))
  {
   atr=atr_cor(_parc(5));
  }
else
  {
    _retni(-1);
    return;
  }
p= area;
total=(c1-c)+1;
for ( i = l; i <= l1 ; i++)
	{
	 pos_data=i*(MAXCOLUN*2)+c*2;
	 movedata(VIDEO,pos_data,FP_SEG(p),FP_OFF(p),(total)*2);
	 for ( j=1; j<(total*2); j+=2)
		{
		   area[j]=atr;
		}
	 movedata(FP_SEG(p),FP_OFF(p),VIDEO,pos_data,(total)*2);
	}
	_retni(0);
	return;
}
