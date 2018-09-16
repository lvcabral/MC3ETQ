;-----------------------------------------------------------------------------
;  Program file..: CLOCK.asm
;  Author........: Rick Whitt
;  Enhancements..: Marcelo Leal Cabral
;  Date..........: 1/21/88
;  Used by.......: Clipper, Summer '87
;  Function......: Displays ( or cancels display of ) a continuously updated
;                  clock at a specified screen row & col with a specified
;                  attributes (color). The task of clearing the screen after
;                  the display is turned off is left to the calling procedure.
;
;                  The CLOCK.obj file must be linked into your application
;                  to use the procedure. The function operates by redirecting
;                  the address of the BIOS timer interrupt routine to a
;                  point inside of your application. The PC issues a timer
;                  interrupt roughly 18.2 times per second. Each time, the
;                  code inside of this routine gets control. Every 9
;                  interrupts, the time is recalculated and displayed.
;                  When all necessary work is done by the local routines,
;                  processing is passed on to the normal BIOS timer
;                  interrupt routine, whose function is to update the
;                  system's time-of-day clock. When the clock is turned off,
;                  execution of the timer interrupt is returned to normal.
;
;
;                  Syntax of the call is as follows:
;
;                  status = CLOCK( mode, row, col, attr )
;
;                  where: mode = 0 to turn display OFF
;                         mode = 1 to turn display ON
;
;                         row  = row coordinate for clock from 0 to 49
;                         col  = col of clock display from 0 to 79
;
;                         attr = attributes for display. The rules
;                                for calculating the attribute figures are
;                                detailed below.
;
;                  The function returns either a 1 if on, 0 if off, or
;                  -1 if one of the parameters was out of range.
;
;
;                  * IMPORTANT NOTES *
;
;                  Be certain that you turn the display OFF before your
;                  program terminates! Failure to do this will leave the
;                  address of the timer interrupt vectored to a point in
;                  memory which no longer will allow normal processing,
;                  causing unpredictable results. Therefore, it is advised
;                  that these routines only be used after complete debugging,
;                  when you can be confident of a predictable exit of your
;                  application.
;
;                  - Attribute values
;
;                  The attribute number is a one byte number that is used
;                  to set foreground and background colors, and also
;                  intensity.
;
;                  For Monochrome:   Normal ......................   7
;                                    Intense .....................  15
;                                    Normal underlined ...........   1
;                                    Intense underlined ..........   9
;                                    Reverse ..................... 112
;                                    Blinking normal ............. 135
;                                    Blinking intense ............ 143
;                                    Blinking normal underlined .. 129
;                                    Blinking intense underlined . 137
;                                    Blinking reverse ............ 240
;
;                  -----------------------------------------------------
;
;                  For color:        Foreground          Background
;                                    ----------          ----------
;
;                     Black              0                    0
;                     Blue               1                   16
;                     Green              2                   32
;                     Cyan               3                   48
;                     Red                4                   64
;                     Magenta            5                   80
;                     Brown              6                   96
;                     White              7                  112
;
;                     Gray               8
;                     Light blue         9
;                     Light green       10
;                     Light cyan        11                  Not
;                     Light red         12               Available
;                     Light magenta     13
;                     Yellow            14
;                     Bright white      15
;
;
;                     To get the color attribute, add the numbers together
;                     of the foreground and background colors that you
;                     want. Add 128 to this to make it blink. For example:
;
;                     YELLOW on RED =  14 + 64  =  78
;
;                     To make the above blinking, add 128 + 78 = 206
;
;
;----------------------------------------------------------------------------


public  Clock1

extrn   __parni:far
extrn   __parinfo:far
extrn   __retni:far

dgroup  group   datasg

datasg  segment public  '_DATA'

Old_1c          dd      0                       ; old INT 1Ch saved here
AreWeOn         dw      0                       ; on/off flag
TickCount       db      0                       ; increment on each interrupt
Attr            db      ?                       ; display attribute
Row             db      ?                       ; display coordinates
Col             db      ?
VideoSeg        dw      0B800H                  ; video segment address
VideoPage       db      1                       ; video page
VideoPort       dw      ?                       ; video status port

ClockOffset     dw      0                       ; video offset of clock

hh              dw      0                       ; hours
mm              dw      0                       ; minutes
sc              dw      0                       ; seconds
hhdiv           dw      32771                   ; hours divisor (65543/2)
mmdiv           dw      546                     ; minutes divisor (1092/2)
ssdiv           dw      9                       ; second divisor (18/2)

Hours           dw      ?                       ; this is the clock display
                db      ':'
Minutes         dw      ?
                db      ':'
Seconds         dw      ?


datasg  ends


_prog   segment 'CODE'
        assume  cs:_prog,ds:dgroup,es:nothing,ss:nothing




Clock1          proc    far

                push    bp              ; save return address
                mov     bp,sp           ; address variable on stack
                push    ds              ; must save regs
                push    es
                push    si
                push    di


                mov     ah,15           ; get video mode and page number
                int     10h
                mov     VideoPage,bh    ; save page number

                cmp     al,7                    ; mono ?
                jne     Color                   ; no, then jump
                mov     VideoSeg,0b000h         ; save address and
                mov     VideoPort,03bah         ; video port
                jmp     DoneWithDisplay

Color:
                mov     VideoSeg,0b800h
                mov     VideoPort,03dah

DoneWithDisplay:


                xor     ax,ax           ; get number of parameters
                push    ax
                call    __parinfo       ; call information function
                add     sp,2            ; fix up stack
                cmp     al,0
                je      Mid_Jump
                cmp     al,4
                jne     ParamError      ; exit if not 4 parameters

                mov     ax,2            ; get 2nd parameter
                push    ax
                call    __parni
                add     sp,2
                cmp     al,0
                jb      ParamError      ; exit with error if not valid
                cmp     al,49
                ja      ParamError
                mov     Row,al          ; else save the row number

                mov     ax,3            ; get Column number
                push    ax
                call    __parni
                add     sp,2
                cmp     al,0
                jb      ParamError
                cmp     al,79
                ja      ParamError
                mov     Col,al
                jmp     CalcClock

Mid_Jump:
                jmp     StatOnly

CalcClock:
                mov     dh,Row          ; calculate clock's video offset
                mov     dl,Col
                call    Get_Offset
                mov     ClockOffset,di


                mov     ax,4            ; get attribute
                push    ax
                call    __parni
                add     sp,2
                cmp     al,0
                jb      ParamError
                mov     Attr,al

                mov     ax,1            ; get 1st parameter
                push    ax
                call    __parni
                add     sp,2
                cmp     al,0
                jz      CutOff          ; cut clock off if 0


                mov     AreWeOn,1       ; otherwise, cut on and exit
                call    Steal_Int1c
                jmp     StatOnly
Cutoff:
                mov     AreWeOn,0
                call    Reset_Int1c
                jmp     StatOnly

ParamError:
                mov     ax,-1
                jmp     Exit
StatOnly:
                mov     ax,AreWeOn

Exit:
                push     ax             ; push return value onto stack
                call     __retni        ; and return it
                add      sp,2

                pop     di
                pop     si
                pop     es              ; restore registers
                pop     ds
                pop     bp
                ret                     ; far return to Clipper

Clock1          endp






;-----------------------------------------------------------;
; Local subroutine - steals interrupt 1Ch for our purposes  ;
;-----------------------------------------------------------;

Steal_Int1C     proc    near

                push    ds                      ; save registers
                push    es
                push    dx
                push    bx
                push    ax


;
; Get and save current vector for INT 1Ch
;
                mov     ax,351Ch                ; get INT 1C to ES:BX
                int     21h
                mov     word ptr Old_1C,bx      ; save offset
                mov     word ptr Old_1C[2],es   ; save segment

;
; Set INT 1C to point to our local routine
;
                push    cs
                pop     ds
                mov     dx,offset cs:New_1C     ; offset of local interrupt
                                                ;  routine..segment in DS
;
; DS:DX now points to local interrupt routine
;
                mov     ax,251Ch                ; set interrupt 1C
                int     21h

                pop     ax                      ; restore registers
                pop     bx
                pop     dx
                pop     es
                pop     ds
                ret                             ; near return

Steal_Int1C     endp



;---------------------------------------------------;
; Local subroutine - restore original 1Ch vector    ;
;---------------------------------------------------;

Reset_Int1C     proc    near

                push    ds                      ; save registers
                push    dx
                push    ax

                lds     dx,dgroup:Old_1C        ; seg/off of original 1Ch
                mov     ax,251Ch                ; set 1Ch
                int     21h

                pop     ax                      ; restore registers
                pop     dx
                pop     ds
                ret

Reset_Int1C     endp



;-----------------------------------------------------------;
; Local subroutine - Convert row in dh and col in dl to     ;
; an offset in video memory.                                ;
;-----------------------------------------------------------;

Get_Offset      proc    near

                push    ds                      ; save registers
                push    dx
                push    ax

                mov     bl,VideoPage            ; page #
                xor     bh,bh                   ; zero BH

                mov     al,160                  ; row * 160
                mul     dh                      ; result in AX
                shl     dl,1                    ; col * 2
                xor     dh,dh                   ; byte to word in DX
                add     ax,dx                   ; add the two
                mov     di,ax                   ; save result in DI
                mov     ax,1000h                ; length of 1 video page
                mul     bx                      ; page * 1000
                add     di,ax                   ; complete offset address

                pop     ax                      ; restore registers
                pop     dx
                pop     ds
                ret

Get_Offset      endp




;--------------------------------------------------------------------;
; Entry point of local interrupt 1Ch routine - displays current time ;
; Main routine gets control every 9 clock ticks - roughly 1/2 sec.   ;
;--------------------------------------------------------------------;

New_1C          proc    far

                push    ax                      ; save changed registers
                push    bx
                push    cx
                push    dx

                mov     dx,seg dgroup:TickCount
                mov     ds,dx

                pushf
                call    ds:Old_1C               ; call to normal 1Ch

                inc     TickCount               ; increment the count
                cmp     TickCount,9             ; up to 9 yet ?
                je      ProcessTime             ; yes, then carry out display

Done:
                sti
                assume  es:nothing
                pop     dx                      ; restore registers
                pop     cx
                pop     bx
                pop     ax

                iret                            ; interrupt return

ProcessTime:
                mov     TickCount,0             ; reset counter

                xor     ax,ax           ; Set up for clock read.
                int     1ah             ; Read the clock.
                mov     bx,dx           ; Save low(minutes) portion.
                mov     dx,cx           ; Move high(hours) portion to AX.
                mov     ax,bx           ; dx:ax = clock count

                clc
                rcr     dx,1            ; div count by 2 so we can use a
                rcr     ax,1            ; single precision dividend

                div     hhdiv           ; compute hours
                mov     hh,ax           ; save it
                mov     ax,dx           ; prepare remainder for minutes
                xor     dx,dx
                div     mmdiv           ; compute minutes

                cmp     ax,60           ; 60 minutes shows up sometimes
                jl      mm_ok           ; mostly it doesn't
                xor     ax,ax           ; but if it does, zero out the minutes
                inc     hh              ; and bump up the hour

mm_ok:          mov     mm,ax           ; save it
                mov     ax,dx           ; prepare remainder for seconds
                xor     dx,dx
                div     ssdiv           ; compute seconds
                cmp     ax,60
                jl      sc_ok
                xor     ax,ax
                inc     mm
                cmp     mm,60
                jl      sc_ok
                mov     mm,0
                inc     hh
                cmp     hh,24
                jl      sc_ok
                mov     hh,0

sc_ok:          mov     sc,ax           ; save it

                lea     bx,hours        ; Set up BX as pointer to display string

                mov     ax,hh
                aam                     ; Convert AX to BCD - a nice command
                add     ax,3030h        ; Add '0' to both bytes in AX to make ASCII
                mov     [bx+0],ah       ; Move first hours digit into display
                mov     [bx+1],al       ; Then the second digit

                mov     ax,mm           ; get minutes
                aam                     ; Again convert AX to Binary Coded Decimal
                add     ax,3030h        ; Add to make two ASCII characters
                mov     [bx+3],ah       ; and move them into the display in memory
                mov     [bx+4],al

                mov     ax,sc           ; get seconds
                aam                     ; Again convert AX to Binary Coded Decimal
                add     ax,3030h        ; Add to make two ASCII characters
                mov     [bx+6],ah       ; and move them into the display in memory
                mov     [bx+7],al



                push    es
                push    di
                push    si

                mov     es,VideoSeg             ; set ES to video segment
                mov     di,ClockOffset


                mov     dx,offset dgroup:Hours  
                mov     si,dx

                mov     ah,Attr                 ; attribute of status
                mov     cx,8                    ; 10 characters to write

Clk_Loop:
                lodsb                           ; get character in AL
                stosw                           ; write char/attr pair
                loop    Clk_Loop                ; loop till done

                pop     si
                pop     di
                pop     es

                jmp     Done


New_1C          endp


_prog           ends
                end

