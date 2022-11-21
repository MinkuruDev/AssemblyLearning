.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      ENTER,"Nhap vao 1 chu cai: $"
    msg1    DB      ENTER,"Ky tu nhap vao khong phai chu cai!$"
    msg2    DB      ENTER,"3 Ky tu lien truoc cua ky tu nhap vao la: $"
    msg3    DB      ENTER,"3 Ky tu lien sau cua ky tu nhap vao la: $"
    char    DB      ?

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        MOV AH,9
        LEA DX,msg
        INT 21h

        MOV AH,1
        INT 21h

        CMP AL,"A"
        JL _ERROR
        CMP AL,"Z"
        JLE _PRINT

        CMP AL,'a'
        JL _ERROR
        CMP AL,'z'
        JG _ERROR
        JMP _PRINT

        _ERROR:
            MOV AH,9
            LEA DX,msg1
            INT 21h
            JMP _EXIT

        _PRINT:
        MOV char,AL
        LEA DX,msg2
        MOV AH,9
        INT 21h

        MOV CX,3
        MOV AH,2
        MOV DL,char
        SUB DL,3

        _FRONT:
            INT 21h
            INC DL
            LOOP _FRONT

        LEA DX,msg3
        MOV AH,9
        INT 21h

        MOV CX,3
        MOV AH,2
        MOV DL,char
        ADD DL,1

        _BACK:
            INT 21h
            INC DL
            LOOP _BACK

        _EXIT:
        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
