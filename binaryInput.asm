.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao so nhi phan: $"
    msg1    DB      ENTER,"So nhap vao khong phai nhi phan, nhap lai: $"
    msg2    DB      ENTER,"So nhi phan da nhap: $"
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
            JE _PROCESS
            CMP AL,'1'
            JE _PROCESS

            JMP _WRONG_INPUT

            _PROCESS:
                SUB AL,30h
                MOV AH,0
                SHL BX,1
                OR BX,AX

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
