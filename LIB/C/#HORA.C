/********************************************************************
* ARQUIVO..: Hora.OBJ                                               *
* PROGRAMA.: Fun‡ao em C para o Clipper Summer'87                   *
* AUTORES..: Luiz Antonio Quintela e M rio S‚rgio L. Pimentel       *
* FONTE....: "CLIPPER COM LINGUAGEM C" Editora Mc Graw Hill         *
* ADAPTA€AO: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 31 de Outubro de 1991                                  *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* HORA()...: Muda a Hora do Sistema (Retorna .F. se Houver Erro)    *
*                                                                   *
********************************************************************/

#include <clipper5.h>
#include <dos.h>

CLIPPER hora()
{
 char  hora[9], hh[3], mm[3], ss[3];

 union REGS hr;
 if (PCOUNT != 1 || ! ISCHAR(1))
                {
                 _retl(0);
                 return;
                }
 strcpy(hora,_parc(1));
 strcpy(hh,hora,2);
 strcpy(mm,&hora[3],2);
 strcpy(ss,&hora[6],2);
 hh[2] = mm[2]= ss[2] = '\0';

 hr.h.ah = 0x2D;
 hr.h.ch = atoi(hh);
 hr.h.cl = atoi(mm);
 hr.h.dh = atoi(ss);
 hr.h.dl = 0;

     if (hr.h.ch < 0 || hr.h.ch > 23 || hr.h.cl < 0 || hr.h.cl > 59 ||
         hr.h.dh < 0 || hr.h.dh > 59)
         {
          _retl(0);
          return;
         }

     intdos(&hr,&hr);
     if (hr.h.al == 0) _retl(1); else _retl(0);
     return;
}

/*eof*/

