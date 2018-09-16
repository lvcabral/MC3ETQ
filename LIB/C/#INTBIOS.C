/********************************************************************
* ARQUIVO..: INTBIOS.C                                              *
* PROGRAMA.: Fun‡ao em C para o Clipper Summer'87                   *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 16 de Maio de 1992                                     *
* ALTERACAO: 06 de Junho de 1992                                    *
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* INTBIOS(): Realiza a chamada das interrup‡”es da bios             *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <dos.h>
static union REGS regs;
CLIPPER intbios()
{
  char *cl_ax,*cl_bx,*cl_cx,*cl_dx;
  int  tc_ax,tc_bx,tc_cx,tc_dx;
  cl_ax=_parc(2);
  cl_bx=_parc(3);
  cl_cx=_parc(4);
  cl_dx=_parc(5);
  tc_ax=atoi(cl_ax);
  tc_bx=atoi(cl_bx);
  tc_cx=atoi(cl_cx);
  tc_dx=atoi(cl_dx);
  regs.x.ax=tc_ax;
  regs.x.bx=tc_bx;
  regs.x.cx=tc_cx;
  regs.x.dx=tc_dx;
  int86(_parni(1),&regs,&regs);
  itoa(regs.x.ax,cl_ax,10);
  itoa(regs.x.bx,cl_bx,10);
  itoa(regs.x.cx,cl_cx,10);
  itoa(regs.x.dx,cl_dx,10);
  _ret();
  return;
}

