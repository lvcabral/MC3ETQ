/*********************************************************************
* ARQUIVO...: Linhah.OBJ                                             *
* PROGRAMA..: Fun‡ao em C para o Clipper Summer'87                   *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 13 de Abril de 1991                                    *
* ALTERA€AO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Linhah()..: Desenha uma linha no horizontal modo gr fico.          *
*                                                                    *
*********************************************************************/

#include <clipper5.h>

extern void _linhah();
extern void _ponto();

CLIPPER linhah()
{
 _linhah(_parni(1),_parni(2),_parni(3),_parni(4));
 _ret();
 return;
}

void _linhah(lin_gr,col1_gr,col2_gr,cor_gr)
int lin_gr;
int col1_gr;
int col2_gr;
int cor_gr;
{
 int inic;
 for(inic=col1_gr;inic<=col2_gr;inic++)
 {
  _ponto(lin_gr,inic,cor_gr);
  }
 return;
}
