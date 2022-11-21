.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao so nhi phan: $"
    msg1    DB      ENTER,"So nhap vao khong phai nhi phan, nhap lai: $"
    msg2    DB      ENTER,"So Thap luc phan: $"
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

        MOV CH,4
        _WHILE_PRINT:
            MOV CL,4
            MOV DL,0
            _PRINT_CHAR:
                SHL DX,1
                SHL BX,1
                JNC _NOT_CARRY
                OR DX,1
                _NOT_CARRY:
                DEC CL
                JNZ _PRINT_CHAR

            CMP DL,10
                JL _PRINT
                ADD DL,7

                _PRINT:
                    ADD DL,30h
                    MOV AH,2
                    INT 21h
                
            DEC CH
            JNZ _WHILE_PRINT

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
