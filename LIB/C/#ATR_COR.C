/********************************************************************
* ARQUIVO..: Atr_Cor.c                                              *
* PROGRAMA.: Fun‡ao em C para o Clipper v5.01                       *
* AUTOR....: Marcelo Leal Limaverde Cabral                          *
* DATA.....: 15 de julho de 1992                                    *
* ALTERACAO: 19 de setembro de 1992
*********************** FUN€AO DEFINIDA *****************************
*                                                                   *
* ATR_COR..: Converte uma definicao de cores de carac. para num.    *
*                                                                   *
********************************************************************/
#include <clipper5.h>
#include <string.h>
#define N        0x00
#define B        0x01
#define G        0x02
#define R        0x04
#define W        0x07
#define I        0x08
#define BLI      0x80
#define MAXATRIB 20
unsigned int atr_cor(char *);

CLIPPER atrcor()
{
 _retni(atr_cor(_parc(1)));
 return;
}

unsigned int atr_cor(cor)
char *cor;
{
unsigned char  atr=0x00, str_atr[MAXATRIB], *p_aux;
unsigned int i;

strcpy(str_atr,cor);

if ((p_aux = strchr(str_atr,'/'))== NULL)
	{
	   return(0);
	}
p_aux++;
for (; *p_aux; p_aux++)
    {
       switch (*p_aux)
	      {
		case 'B' :
			   atr += B;
			   break;
		case 'G' :
			   atr += G;
			   break;
		case 'R' :
			   atr += R;
			   break;
		case 'W' :
			   atr += (R+G+B);
			   break;
		case 'N' :
		case '*' :
		case '+' :
		case ' ' :
			   continue;
		default  :
			   return(0);
		}
	      }
atr <<= 4;
for ( i=0; str_atr[i] != '/'; i++)
    {
      switch(str_atr[i])
	      {
		case 'B' :
			   atr += B;
			   break;
		case 'G' :
			   atr += G;
			   break;
		case 'R' :
			   atr += R;
			   break;
		case 'W' :
			   atr +=(R+G+B);
			   break;
		case 'N' :
		case '*' :
		case '+' :
		case ' ' :
			   continue;
		default  :
			   return(0);
		}
	      }
if (strchr(str_atr,'*') != NULL)
    {
    atr+= BLI;
    }
if (strchr(str_atr,'+') != NULL)
    {
    atr+= I;
    }
return(atr);
}
