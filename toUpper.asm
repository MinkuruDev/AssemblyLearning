.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg1    DB      "Nhap vao ky tu: $"
    msg2    DB      ENTER,"Ky tu in hoa: $"
    char    DB      ?

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg1
        LEA DX,msg1
        MOV AH,9
        INT 21h   
        
        ; input a char, store in AL
        MOV AH,1
        INT 21h

        ; to upper, store in char
        CMP AL,'a'
            JB _END_IF
        CMP AL,'z'
            JA _END_IF
        SUB AL,20h

        _END_IF:
            MOV char,AL

        ; output msg2
        LEA DX,msg2
        MOV AH,9
        INT 21h

        ; output to upper
        MOV DL,char
        MOV AH,2
        INT 21h

        ; exit
        MOV AH,4CH
        INT 21h

    main ENDP
    END main
