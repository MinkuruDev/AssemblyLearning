.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao 1 ky tu: $"
    msg1    DB      ENTER,"Good Morning$"
    msg2    DB      ENTER,"Good Afternoon$"
    msg3    DB      ENTER,"Good Evening$"
    char    DB      ?

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg / a string
        LEA DX,msg
        MOV AH,9
        INT 21h

        ; input a char, store in char
        MOV AH,1
        INT 21h
        MOV char,AL

        ; if char == 's' or char == 'S'
        CMP AL,'s'
            JE _MORNING
        CMP AL,'S'
            JE _MORNING

        ; if char == 'c' or char == 'C'
        CMP AL,'c'
            JE _AFTERNOON
        CMP AL,'C'
            JE _AFTERNOON

        ; if char == 'e' or char == 'E'
        CMP AL,'e'
            JE _EVENING
        CMP AL,'E'
            JE _EVENING
        JMP _END_IF

        _MORNING:
            LEA DX,msg1
            JMP _PRINT

        _AFTERNOON:
            LEA DX,msg2
            JMP _PRINT

        _EVENING:
            LEA DX,msg3
            JMP _PRINT
        
        _PRINT:
            MOV AH,9
            INT 21h
        
        _END_IF:

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
