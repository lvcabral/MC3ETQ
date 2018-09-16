/*
 * File......: ISBIT.PRG
 * Author....: Forest Belt, Computer Diagnostic Services, Inc.
 * Date......: 15 Aug 1991 23:03:46  
 * Revision..: 1.2
 * 
 * This is an original work by Forest Belt and is placed in the
 * public domain.
 *
 * Nanforum Toolkit
 *
 */
 
FUNCTION ISBIT(cInbyte,nBitPos)

  LOCAL lBitStat

  IF valtype(cInbyte) != "C" .or. valtype(nBitPos) != "N"  // parameter check
     lBitStat := NIL
  ELSE
     if (nBitPos > 7) .or. (nBitPos < 0) .or. (nBitPos != int(nBitPos))
        lBitStat := NIL
     else
        lBitStat := int(((asc(cInByte) * (2 ^ (7 - nBitPos))) % 256) / 128) == 1
     endif
  ENDIF

RETURN lBitStat

