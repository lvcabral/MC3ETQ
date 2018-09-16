**********************************************************************
* ARQUIVO...: !Circulo.OBJ                                           *
* PROGRAMA..: Fun‡ao para o Clipper Summer'87                        *
* AUTOR.....: Marcelo Leal Limaverde Cabral                          *
* DATA......: 10 de Outubro de 1991                                  *
* ALTERACAO.: 08 de Junho de 1992                                    *
************************ FUN€AO DEFINIDA *****************************
*                                                                    *
* Circulo().: Desenha um Circulo na Tela Gr fica.                    *
*                                                                    *
**********************************************************************
FUNCTION CIRCULO
PARAM LC,CC,RAIO,COR
PRIVATE ANGULO,Cpt,Lpt
FOR ANGULO=1 TO 360 
    Cpt=(RAIO*_tabcos(angulo)+CC)
    Lpt=(RAIO*_tabsen(angulo)+LC)
    PONTO(LPT,CPT,COR)
NEXT
RETURN(.T.)
