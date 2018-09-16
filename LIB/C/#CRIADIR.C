/*********************************************************************
* ARQUIVO...: CriaDir.OBJ                                            *
* PROGRAMA..: Biblioteca de fun‡oes em C para o Clipper Summer'87    *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 02 de Setembro de 1990                                 *
* ALTERACAO.: 06 de Junho de 1992                                    *
********************** FUN€OES DEFINIDAS *****************************
*                                                                    *
* CRIADIR().: Cria um Novo Diret¢rio (Retorna .F. se Houver Erro)    *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dir.h>

CLIPPER criadir()
{
if (PCOUNT==1 && ISCHAR(1))
 _retl(mkdir(_parc(1)) == 0 ? 1 : 0);
else
 _retl(FALSE);
return;
}

/*eof*/

