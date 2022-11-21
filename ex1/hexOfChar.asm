.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    fname   DB      "Ho va ten: Nguyen Trung Vinh",ENTER,"Lop: B15D52$"
    de      DB      ENTER,"De bai: Viet chuong trinh thong bao cho nguoi su dung nhap vao 1 ky tu,",ENTER,"In ra ma ASCII cua ky tu duoi dang hex o dong tiep theo,",ENTER,"Lap lai cho den khi nguoi su dung danh ENTER$"
    msg     DB      ENTER,"Nhap vao 1 ky tu: $"
    msg1    DB      ENTER,"Ma ASCII cua $"
    msg2    DB      " duoi dang hex la: $"
    char    DB      ?

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; Viết chương trình thông báo cho người sử dụng nhập vào 1 ký tự,
; in ra mã ASCII của ký tự dưới dạng hex ở dòng tiếp theo.
; Lặp lại cho đến khi người sử dụng đánh ENTER
;
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;
;                                                               ĐỀ BÀI

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        MOV AH,9
        LEA DX,fname
        INT 21h
        LEA DX,de
        INT 21h

        _WHILE_INPUT:
            MOV AH,9
            LEA DX,msg
            INT 21h
            MOV AH,1
            INT 21h

            CMP AL,0Dh
            JE _END_INPUT
            MOV char,AL

            MOV AH,9
            LEA DX,msg1
            INT 21h
            MOV AH,2
            MOV DL,char
            INT 21h
            MOV AH,9
            LEA DX,msg2
            INT 21h

            MOV AX,0
            MOV AL,char
            MOV CX,0
            MOV BL,16

            _DIVISION:
                CMP AX,0
                JE _END_DIV

                DIV BL
                MOV DL,AH
                MOV AH,0
                PUSH DX
                INC CX
                JMP _DIVISION

            _END_DIV:
            
            _HEX_PRINT:
                POP DX
                CMP DL,10
                JL _PRINT
                ADD DL,7

                _PRINT:
                    ADD DL,30h
                    MOV AH,2
                    INT 21h
                
                LOOP _HEX_PRINT

            JMP _WHILE_INPUT
        _END_INPUT:

        MOV AH,4CH
        INT 21h
    main ENDP
    END main