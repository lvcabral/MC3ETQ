/*********************************************************************
* ARQUIVO...: Quadrado.OBJ                                           *
* PROGRAMA..: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 28 de Dezembro de 1991                                 *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Quadrado(): Desenha um Retangulo no modo gr fico.                  *
*                                                                    *
*********************************************************************/
#include <clipper5.h>

extern void _quadrado();
extern void _linhav();
extern void _linhav();

CLIPPER quadrado()
{
 _quadrado(_parni(1),_parni(2),_parni(3),_parni(4),_parni(5));
 _ret();
 return;
}

void _quadrado(lin1,col1,lin2,col2,cor)
unsigned int lin1;
unsigned int col1;
unsigned int lin2;
unsigned int col2;
unsigned int cor;
{
 _linhah(lin1,col1,col2,cor);
 _linhav(col2,lin1,lin2,cor);
 _linhah(lin2,col1,col2,cor);
 _linhav(col1,lin1,lin2,cor);
 return;
}
