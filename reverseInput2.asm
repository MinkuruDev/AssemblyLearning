.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao dong van ban: $"
    msg1    DB      ENTER,"Van ban dao nguoc: $"
    char    DB      ?
    temp    DB      100h DUP (?)

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; "The quick brown fox" -> "fox brown quick The"
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

        MOV CX,0
        MOV BX,0
        LEA SI,temp
        JMP _WHILE_INPUT

        _PROCESS_WORD:
            CMP BX,0
            JE _END_PROCESS

            MOV DX,0
            DEC SI
            MOV DL,[SI]
            PUSH DX
            INC CX
            DEC BX
            JNZ _PROCESS_WORD
        
        _END_PROCESS:
        
        CMP AL,0Dh
        JE _END_INPUT
        MOV DX,20h ; space
        PUSH DX
        INC CX

        _WHILE_INPUT:
            MOV AH,1
            INT 21h
            CMP AL,0Dh
            JE _PROCESS_WORD
            CMP AL,20h
            JE _PROCESS_WORD

            MOV [SI],AL
            INC BX
            INC SI
            JMP _WHILE_INPUT

        _END_INPUT:

        CMP CX,0
        JE _END_PRINT

        LEA DX,msg1
        MOV AH,9
        INT 21h

        _WHILE_PRINT:
            POP DX
            MOV DH,0
            MOV AH,2
            INT 21h

            LOOP _WHILE_PRINT

        _END_PRINT:

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
