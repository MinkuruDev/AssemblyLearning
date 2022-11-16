.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao van ban: $"
    msg1    DB      ENTER,"Cac chu cai trong tu da dao nguoc: $"
    char    DB      ?
    arr     DB      100h DUP (?)

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; "The quick brown fox" -> "ehT kciuq nworb xof"
;
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;
;                                                               ĐỀ BÀI

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg / a string
        LEA DX,msg
        MOV AH,9
        INT 21h
        LEA SI,arr
        JMP _WHILE_INPUT

        _PROCESS_WORD:
            CMP CX,0
            JE _END_PROCESS

            POP DX
            MOV [SI],DL
            INC SI
            DEC CX
            JMP _PROCESS_WORD

        _END_PROCESS:

        MOV [SI],'$'
        CMP AL,0Dh
        JE _END_INPUT
        MOV [SI],20h
        INC SI

        _WHILE_INPUT:
            MOV CX,0

            _INPUT_WORD:
                MOV AH,1
                INT 21h
                CMP AL,0Dh
                JE _PROCESS_WORD
                CMP AL,20h
                JE _PROCESS_WORD

                PUSH AX
                INC CX

                JMP _INPUT_WORD
            
        _END_INPUT:

        MOV AH,9
        LEA DX,msg1
        INT 21h
        LEA DX,arr
        INT 21h

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
