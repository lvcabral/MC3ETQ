****************************************************
* NOME.....: !CONVAC .PRG                          *
* FUN€ŽO...: ConvAC()                              *
* AUTOR....: MARCELO LEAL LIMAVERDE CABRAL         *
* SINTAXE..: ConvAC( cTexto, nModoOrig, nModoDest )*
* DESCRI€ŽO: Converte a acentua‡„o de uma vari vel *
*--------------------------------------------------*
*         Set Modo=1 ----> Tabela BRASCII          *
*         Set Modo=2 ----> Tabela CodePage 850     * 
*         Set Modo=3 ----> Tabela CodePage 860     *
****************************************************

FUNCT ConvAC( cTexto, nModoA, nModoB )

STATIC _ORIGEM[29],_DESTINO[29]

If nModoA==nModoB
   Return( cTexto )
Endif   
   
Do Case
Case nModoA == 1
   _ORIGEM:={248,160,144,130,230,161,231,162,238,163,235,133,236,131,229,;
             136,232,147,233,226,239,249,128,135,165,164,154,129,255}
Case nModoA == 2
   _ORIGEM:={181,160,144,130,214,161,224,162,233,163,183,133,182,131,210,;
             136,226,199,198,229,228,148,128,135,165,164,154,129,255}
Case nModoA == 3
   _ORIGEM:={134,160,144,130,139,161,159,162,150,163,145,133,143,131,137,;
             136,140,147,142,132,153,148,128,135,165,164,154,129,255}
Other
   Return(cTexto)
EndCase

Do Case
Case nModoB == 1
   _DESTINO:={Chr(248),Chr(160),Chr(144),Chr(130),Chr(230),Chr(161),Chr(231),;
              Chr(162),Chr(238),Chr(163),Chr(235),Chr(133),Chr(236),Chr(131),;
              Chr(229),Chr(136),Chr(232),Chr(147),Chr(233),Chr(226),Chr(239),;
              Chr(249),Chr(128),Chr(135),Chr(165),Chr(164),Chr(154),Chr(129),;
              Chr(255)}
Case nModoB == 2
   _DESTINO:={Chr(181),Chr(160),Chr(144),Chr(130),Chr(214),Chr(161),Chr(224),;
              Chr(162),Chr(233),Chr(163),Chr(183),Chr(133),Chr(182),Chr(131),;
              Chr(210),Chr(136),Chr(226),Chr(199),Chr(198),Chr(229),Chr(228),;
              Chr(148),Chr(128),Chr(135),Chr(165),Chr(164),Chr(154),Chr(129),;
              Chr(255)}
Case nModoB == 3
   _DESTINO:={Chr(134),Chr(160),Chr(144),Chr(130),Chr(139),Chr(161),Chr(159),;
              Chr(162),Chr(150),Chr(163),Chr(145),Chr(133),Chr(143),Chr(131),;
              Chr(137),Chr(136),Chr(140),Chr(147),Chr(142),Chr(132),Chr(153),;
              Chr(148),Chr(128),Chr(135),Chr(165),Chr(164),Chr(154),Chr(129),;
              Chr(255)}
Other
   Return(cTexto)
EndCase

CONVERTE(_ORIGEM,_DESTINO,@cTexto)
            
RETURN(cTexto)
