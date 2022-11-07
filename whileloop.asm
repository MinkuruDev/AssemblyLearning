.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg1    DB      "Nhap vao 1 ky tu: $"
    msg2    DB      ENTER,"Ky tu nhap vao khong hop le, nhap lai: $"
    char    DB      ?

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg / a string
        LEA DX,msg1
        MOV AH,9
        INT 21h

        ; input a char, store in char
        _WHILE_WRONG_CHAR:
            ; input a char, store in AL
            MOV AH,1
            INT 21h

            CMP AL,'a'
            JB _WRONG_CHAR
            CMP AL,'z'
            JA _WRONG_CHAR

            MOV char,AL
            JMP _END_WRONG_CHAR

            _WRONG_CHAR:
                LEA DX,msg2
                MOV AH,9
                INT 21h
                JMP _WHILE_WRONG_CHAR

        _END_WRONG_CHAR:

        ; ENTER
        MOV AH,2
        MOV DL,0Dh
        INT 21h
        MOV DL,0Ah
        INT 21h

        ; output char to 'z'
        MOV AH,2
        MOV DL,char

        _PRINT_CHAR:
            INT 21h
            INC DL
            CMP DL,'z'
            JNA _PRINT_CHAR

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
