/********************************************************************
* ARQUIVO..: LinGraf.c                                              *
* PROGRAMA.: Funáao em C para o Clipper Summer'87                   *
* AUTORES..: Carlos Augusto P. Gomes e Antonio Carlos Barbosa       *
* FONTE....: "CLIPPER COM C" Editora êrica                          *
* ADAPTAÄAO: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 04 de Dezembro de 1991                                 *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUNÄAO DEFINIDA *****************************
*                                                                   *
* LinGraf .: Joga uma Linha Grafica em uma posicao definida.        *
*                                                                   *
********************************************************************/

#include <dos.h>
#include <clipper5.h>

#define VIDEO 0xB800
static  char *buff;
static  char far *p;
static  int  pos_data;

CLIPPER lingrafp()
{
   unsigned int l=_parni(1),c=_parni(2),tam=_parni(4);
   buff=_parc(3);
   p=buff;
   pos_data=(l*80)+c;
   movedata(FP_SEG(p),FP_OFF(p),VIDEO,pos_data,tam);
   _retl(TRUE);
   return;
}
CLIPPER lingrafi()
{
   unsigned int l=_parni(1),c=_parni(2),tam=_parni(4);
   buff=_parc(3);
   p=buff;
   pos_data=(l*80)+c;
   movedata(FP_SEG(p),FP_OFF(p),VIDEO,pos_data+0x2000,tam);
   _retl(TRUE);
   return;
}
