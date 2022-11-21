.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao so thap luc phan: $"
    msg1    DB      ENTER,"So khong hop le, Nhap lai: $"
    msg2    DB      ENTER,"So nhi phan cua so da nhap: $"

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg / a string
        LEA DX,msg
        MOV AH,9
        INT 21h
        MOV BX,0
        JMP _WHILE_INPUT

        _WRONG_INPUT:
            LEA DX,msg1
            MOV AH,9
            INT 21h
            MOV BX,0
        
        _WHILE_INPUT:
            MOV AH,1
            INT 21h

            CMP AL,0Dh
            JE _END_INPUT

            CMP AL,'0'
            JL _WRONG_INPUT
            CMP AL,'9'
            JLE _PROCESS

            CMP AL,'A'
            JL _WRONG_INPUT
            CMP AL,'F'
            JG _WRONG_INPUT

            SUB AL,7
            _PROCESS:
                SUB AL,30h
                SHL BX,4
                AND AL,1111b
                OR BL,AL
            JMP _WHILE_INPUT
            
        _END_INPUT:

        LEA DX,msg2
        MOV AH,9
        INT 21h

        MOV CX,16
        MOV AH,2
        _WHILE_PRINT:
            MOV DL,'0'
            SHL BX,1
            JNC _PRINT
            MOV DL,'1'

            _PRINT:
                INT 21h
            
            LOOP _WHILE_PRINT

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
