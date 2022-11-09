.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao so nhi phan: $"
    msg1    DB      ENTER,"So nhap vao khong phai nhi phan, nhap lai: $"
    msg2    DB      ENTER,"So luong so 0: $"
    msg3    DB      ENTER,"So luong so 1: $"

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; Viết chương trình nhập vào số nhị phân. Đếm số lượng bit 1 và bit 0 
; trong số vừa nhập và in kết quả ra màn hình. Nếu nhập sai yêu cầu 
; nhập lại.
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
            JE _COUNT_0
            CMP AL,'1'
            JE _COUNT_1

            JMP _WRONG_INPUT

            _COUNT_0:
                INC BL
                JMP _WHILE_INPUT

            _COUNT_1:
                INC BH

            JMP _WHILE_INPUT

        _END_INPUT:

        ; check count 0 in decimal
        ; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        MOV CX,0
        MOV AH,0
        MOV AL,BL ; count 0 is BL
        MOV BL,10

        _DIVISION:
            CMP AX,0
            JE _END_DIV
        
            DIV BL
            ; remain in AH
            INC CX
            ; stack must push a 16 bit value
            MOV DH,0
            MOV DL,AH
            PUSH DX
            MOV AH,0
            JMP _DIVISION
        
        _END_DIV:

        LEA DX,msg2
        MOV AH,9
        INT 21h

        ; safety loop
        CMP CX,0
        JNE _PRINT:
        PUSH 0
        INC CX   

        _PRINT:
            MOV AH,2
            POP DX
            ADD DL,30h
            INT 21h

            LOOP _PRINT
        ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        ; check count 1 in decimal
        ; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        MOV CX,0
        MOV AH,0
        MOV AL,BH ; count 1 is BH
        MOV BL,10
        _DIVISION1:
            CMP AX,0
            JE _END_DIV1
        
            DIV BL
            ; remain in AH
            INC CX
            MOV DH,0
            MOV DL,AH
            PUSH DX
            MOV AH,0
            JMP _DIVISION1
        
        _END_DIV1:

        LEA DX,msg3
        MOV AH,9
        INT 21h

        CMP CX,0
        JNE _PRINT1:
        PUSH 0
        INC CX   

        _PRINT1:
            MOV AH,2
            POP DX
            ADD DL,30h
            INT 21h

            LOOP _PRINT1
        ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
