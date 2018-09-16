/*********************************************************************
* ARQUIVO...: Nomedir.OBJ                                            *
* PROGRAMA..: Fun‡ao em C para o Clipper 5.01                        *
* AUTORES...: Luiz Antonio Quintela e M rio S‚rgio L. Pimentel       *
* FONTE.....: "CLIPPER COM LINGUAGEM C" Editora Mc Graw Hill         *
* ADAPTA€AO.: Marcelo Leal Limaverde Cabral                          *
* DATA......: 02 de Setembro de 1990                                 *
* ALTERACAO.: 06 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* NOMEDIR().: Retorna o Nome do Diret¢rio Corrente                   *
*                                                                    *
*********************************************************************/

#include <clipper5.h>
#include <dir.h>

CLIPPER Nomedir()
{
char buffer[67];
_retc( getcwd(buffer,66));
return;
}

/*eof*/

