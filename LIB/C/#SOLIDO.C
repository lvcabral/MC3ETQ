/*********************************************************************
* ARQUIVO...: Solido.OBJ                                             *
* PROGRAMA..: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 13 de Abril de 1991                                    *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Solido()..: Desenha um bloco solido na tela gr fica.               *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS sld;
static int ls1_gr,cs1_gr,ls2_gr,cs2_gr,csl_gr,limil,limic;
CLIPPER solido()
{
 ls1_gr=_parni(1);
 cs1_gr=_parni(2);
 ls2_gr=_parni(3);
 cs2_gr=_parni(4);
 csl_gr=_parni(5);
 for(limil=ls1_gr;limil<=ls2_gr;limil++)
 {
    for(limic=cs1_gr;limic<=cs2_gr;limic++)
    {
      impsol(limil,limic);
    }
 }
 _retl(1);
 return;
}
impsol( int lsol, int csol)
{
   sld.x.dx =  lsol;
   sld.x.cx =  csol;
   sld.h.al =  csl_gr;
   sld.h.ah =  12;
   int86(0x10, &sld, &sld);
}