.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao 1 dong van ban:",ENTER,"$"
    msg1    DB      ENTER,"Ky tu in hoa nho nhat la: $"
    msg2    DB      ENTER,"Ky tu in hoa lon nhat la: $"
    msg3    DB      ENTER,"Khong co ky tu in hoa!$"
    char    DB      ?
    first   DB      5Bh ; char after 'Z'
    last    DB      40h ; char before 'A'

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; nhập vào 1 dòng văn bản, in ra ký tự in hoa lớn nhất và nhỏ nhất của
; dòng văn bản vừa nhập. nếu không có ký tự in hoa thì thông báo không
; có ký tự in hoa
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

        _WHILE_INPUT:
            MOV AH,1
            INT 21h

            CMP AL,0Dh ; check CR
            JE _END_INPUT

            ; check upper
            CMP AL,'A'
            JB _WHILE_INPUT
            CMP AL,'Z'
            JA _WHILE_INPUT

            _CHECK_FIRST:
                CMP AL,first
                JAE _CHECK_LAST
                MOV first,AL

            _CHECK_LAST:
                CMP AL,last
                JBE _WHILE_INPUT
                MOV last,AL

            JMP _WHILE_INPUT

        _END_INPUT:

        CMP first,'Z'
        JA _NO_UPPER

        ; smallest char
        LEA DX,msg1
        MOV AH,9
        INT 21h
        MOV AH,2
        MOV DL,first
        INT 21h

        ; biggest char
        LEA DX,msg2
        MOV AH,9
        INT 21h
        MOV AH,2
        MOV DL,last
        INT 21h

        JMP _EXIT_PROGRAM

        _NO_UPPER:
            LEA DX,msg3
            MOV AH,9
            INT 21h

        ; exit
        _EXIT_PROGRAM:
        MOV AH,4CH
        INT 21h

    main ENDP
    END main
