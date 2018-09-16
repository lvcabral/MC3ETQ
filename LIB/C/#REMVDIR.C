/*********************************************************************
* ARQUIVO...: RemvDir.OBJ                                            *
* PROGRAMA..: Biblioteca de fun‡oes em C para o Clipper 5.01         *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 02 de Setembro de 1990                                 *
* ALTERA€AO.: 06 de Junho de 1992                                    *
********************** FUN€OES DEFINIDAS *****************************
*                                                                    *
* REMVDIR().: Apaga um Diret¢rio (Retorna .F. ser Houver Erro)       *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dir.h>

CLIPPER remvdir()
{
if (PCOUNT==1 && ISCHAR(1))
 _retl(rmdir(_parc(1)) == 0 ? 1 : 0);
else
 _retl(FALSE);
return;
}

/*eof*/



