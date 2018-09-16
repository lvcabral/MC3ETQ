/*********************************************************************
* ARQUIVO...: Escreve.OBJ                                            *
* PROGRAMA..: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 13 de Abril de 1991                                    *
* ALTERA€AO.: 14 de Julho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Escreve().: Escreve uma string de caracteres na tela.              *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dos.h>

static union REGS psc;
static union REGS ltr;
extern unsigned int max_col(void);
extern void posicao();
extern void letra();

CLIPPER escreve()
{
 byte *buff;
 register t,l=_parni(1),c=_parni(2),max=max_col();
 unsigned int car;
 buff=_parc(3);
 posicao(l,c);
 for(t=1;t<=_parclen(3);t++)
    {
     car=*buff;
     letra(car,_parni(4));
     buff++;
     c++;
     if(c > max)
      {
       c=0;
       l++;
      }
     posicao(l,c);
    }
 _retl(TRUE);
 return;
}
void posicao(l,c)
unsigned int l;
unsigned int c;
{
 psc.h.dh = l;
 psc.h.dl = c;
 psc.h.bh = 0;
 psc.h.ah = 2;
 int86(0x10, &psc, &psc);
 return;
}
void letra(car,cor)
unsigned int car;
unsigned int cor;
{
 ltr.h.bl = cor;
 ltr.h.al = car;
 ltr.x.cx = 1;
 ltr.h.ah = 9;
 int86(0x10, &ltr, &ltr);
 return;
}




