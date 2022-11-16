.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao chuoi ky tu: $"
    msg1    DB      ENTER,"Chuoi ky tu dao nguoc la: $"
    char    DB      ?

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; Nhập vào 1 dãy kí tự, in ra dãy ký tự đó đảo ngược
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
        _WHILE_INPUT:
            MOV AH,1
            INT 21h
            CMP AL,0Dh
            JE _END_INPUT

            PUSH AX
            INC CX

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
