; File......: ADAPTER.ASM
; Author....: Ted Means
; Date......: $Date:   15 Aug 1991 23:07:18  $
; Revision..: $Revision:   1.2  $
; Log file..: $Logfile:   E:/nanfor/src/adapter.asv  $
; 
; This is an original work by Ted Means and is placed in the
; public domain.
;
; Modification history:
; ---------------------
;
; $Log:   E:/nanfor/src/adapter.asv  $
;  
;     Rev 1.2   15 Aug 1991 23:07:18   GLENN
;  Forest Belt proofread/edited/cleaned up doc
;  
;     Rev 1.1   14 Jun 1991 19:54:18   GLENN
;  Minor edit to file header
;  
;     Rev 1.0   01 Apr 1991 01:03:08   GLENN
;  Nanforum Toolkit
;  
;



;  $DOC$
;  $FUNCNAME$
;     ADAPTER()
;  $CATEGORY$
;     Video
;  $ONELINER$
;     Report the type of video adapter installed
;  $SYNTAX$
;     ADAPTER() -> nResult
;  $ARGUMENTS$
;     None
;  $RETURNS$
;     Integer representing type of video adapter
;
;        0 - monochrome
;        1 - CGA
;        2 - EGA
;        3 - VGA
;  $DESCRIPTION$
;     This function is valuable if you use a graphics library and need to
;     know what type of graphics adapter is installed.
;
;     The source code is written to adhere to Turbo Assembler's IDEAL mode.
;     To use another assembler, you will need to rearrange the PROC and
;     SEGMENT directives, and also the ENDP and ENDS directives (a very
;     minor task).
;  $EXAMPLES$
;     iVideo := ADAPTER()
;
;     DO CASE
;        CASE iVideo == 0
;           QOUT( "You have a monochrome adapter." )
;        CASE iVideo == 1
;           QOUT( "You have a CGA adapter." )
;        CASE iVideo == 2
;           QOUT( "You have an EGA adapter." )
;        CASE iVideo == 3
;           QOUT( "You have a VGA adapter." )
;     ENDCASE
;  $SEEALSO$
;     FT_SETMODE()
;  $END$
;

         IDEAL

Public   ADAPTER

Extrn    __RetNI:Far

Segment  _NanFor   Word      "CODE"
         Assume    CS:_NanFor

Proc     ADAPTER          Far

         Xor       BX,BX                     ; Clear BX
         Mov       ES,BX                     ; Set ES to low memory
         Cmp       [Word Ptr ES:463h],3B4h   ; See if mono
         JE        Done                      ; If so, we're done

IsVGA:   Mov       AX,1A00h                  ; VGA-only BIOS call
         Int       10h                       ; Call video BIOS
         Cmp       AL,1Ah                    ; See if call supported
         JNE       IsEGA                     ; If not, try EGA
         Mov       BX,3                      ; Indicate VGA
         JMP       Short Done                ; Return to application

IsEGA:   Mov       AH,12h                    ; EGA-only BIOS call
         Mov       BL,10h                    ; Set BL to test value
         Int       10h                       ; Call video BIOS
         Cmp       BL,10h                    ; Did BL change?
         JE        IsCGA                     ; No, so it's a CGA
         Mov       BX,2                      ; Indicate EGA
         Jmp       Short Done                ; Return to application

IsCGA:   Mov       BX,1                      ; Indicate CGA

Done:    Push      BX                        ; Save adapter type on stack
         Call      __RetNI                   ; Return it
         Add       SP,2                      ; Realign stack
         Ret
Endp     ADAPTER
Ends     _NanFor
End
