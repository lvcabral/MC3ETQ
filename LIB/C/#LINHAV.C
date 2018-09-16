/*********************************************************************
* ARQUIVO...: Linhav.OBJ                                             *
* PROGRAMA..: Fun‡ao em C para o Clipper Summer'87                   *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 13 de Abril de 1991                                    *
* ALTERACAO.: 06 de junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Linhav()..: Desenha uma linha no vertical modo gr fico.            *
*                                                                    *
*********************************************************************/
#include <clipper5.h>

extern void _linhav();
extern void _ponto();

CLIPPER linhav()
{
 _linhav(_parni(1),_parni(2),_parni(3),_parni(4));
 _ret();
 return;
}

void _linhav(col_gr,lin1_gr,lin2_gr,cor_gr)
int col_gr;
int lin1_gr;
int lin2_gr;
int cor_gr;
{
 int inic;
 for(inic=lin1_gr;inic<=lin2_gr;inic++)
 {
  _ponto(inic,col_gr,cor_gr);
  }
 return;
}
