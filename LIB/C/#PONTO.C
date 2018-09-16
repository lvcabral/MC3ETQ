/*********************************************************************
* ARQUIVO...: Ponto.OBJ                                              *
* PROGRAMA..: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 13 de Abril de 1991                                    *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Ponto()...: Desenha um Ponto na Tela Gr fica.                      *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS pt;
extern void _ponto();

CLIPPER ponto()
{
 _ponto(_parni(1),_parni(2),_parni(3));
 _ret();
 return;
}
void _ponto(lin,col,cor)
unsigned int lin;
unsigned int col;
unsigned int cor;
{
 pt.x.dx =  lin;
 pt.x.cx =  col;
 pt.h.al =  cor;
 pt.h.ah = 12;
 int86(0x10, &pt, &pt);
 return;
}
