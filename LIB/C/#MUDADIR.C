/*********************************************************************
* ARQUIVO...: MudaDir.OBJ                                            *
* PROGRAMA..: Biblioteca de fun‡oes em C para o Clipper 5.01         *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 02 de Setembro de 1990                                 *
* ALTERA€AO.: 06 de Junho de 1992                                    *
********************** FUN€OES DEFINIDAS *****************************
*                                                                    *
* MUDADIR().: Muda o Diret¢rio Corrente (Retorna .F. se Houver Erro) *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dir.h>

CLIPPER mudadir()
{
if (PCOUNT==1 && ISCHAR(1))
 _retl(chdir(_parc(1)) == 0 ? 1 : 0);
else
 _retl(FALSE);
return;
}

/*eof*/


