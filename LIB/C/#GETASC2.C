#include <clipper5.h>
#include <dos.h>
#define TABCGA 0x1F
#define TABEGA 0x43

static unsigned char *tabela,*ret;

CLIPPER getascii()
{
 unsigned int ct,tam;
 ret=_parc(1);
 tam=_parclen(1);
 if (tam==1024)
  {
   tabela=getvect(TABCGA);
  }
 else
  {
   tabela=getvect(TABEGA);
  }
 for(ct=1;ct<=tam;ct++)
  {
    *ret++=*tabela++;
  }
 _ret();
 return;
}