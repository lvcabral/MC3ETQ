/********************************************************************
* ARQUIVO..: Now.OBJ                                                *
* PROGRAMA.: Fun‡ao em C para o Clipper 5.01                        *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 29 de Mar‡o de 1992                                    *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* NOW()....: Retorna a Hora do Sistema com cent‚simos.              *
*                                                                   *
********************************************************************/

#include <clipper5.h>
#include <dos.h>

CLIPPER now()
{
 char  hora[5];

 union REGS hr;
 hora[4] = '\0';
 hr.h.ah = 0x2C;

 intdos(&hr,&hr);

 hora[0] = hr.h.ch;
 hora[1] = hr.h.cl;
 hora[2] = hr.h.dh;
 hora[3] = hr.h.dl;
 _retc(hora);
 return;
}

/*eof*/

