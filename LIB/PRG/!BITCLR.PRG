/*
 * File......: BITCLR.PRG
 * Author....: Forest Belt, Computer Diagnostic Services, Inc.
 * Date......: 15 Aug 1991 23:02:50  
 * Revision..: 1.2  
 * 
 * This is an original work by Forest Belt and is placed in the
 * public domain.
 *
 * Nanforum Toolkit
 *
 */

FUNCTION BITCLR(cInbyte, nBitpos)

  LOCAL cByte

  IF valtype(cInbyte) != "C" .or. valtype(nBitpos) != "N"  // parameter check
     cByte := NIL
  ELSE
     IF (nBitPos > 7) .or. (nBitPos < 0) .or. (nBitPos != int(nBitPos))
        cByte := NIL
     ELSE
        cByte := iif( .not. ISBIT(cInByte, nBitpos), cInByte, ;
                            chr(asc(cInByte) - (2 ^ nBitpos)))
     ENDIF
  ENDIF

RETURN cByte

