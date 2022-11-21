.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    fname   DB      "Ho va ten: Nguyen Trung Vinh",ENTER,"Lop: B15D52$"
    de      DB      ENTER,"De bai: Nhap vao 1 chu cai tu ban phim, neu chu do la hoa thi in ra",ENTER,"Neu do la chu thuong thi chuyen thanh chu hoa va in ra man hinh$"
    msg     DB      ENTER,"Nhap vao 1 chu cai: $"
    msg1    DB      ENTER,"Ky tu nhap vao khong phai chu cai!$"
    msg2    DB      ENTER,"Chu cai in hoa cua ky tu nhap vao: $"
    char    DB      ?

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; Viết chương trình nhập vào 1 chữ cái từ bàn phím, nếu chữ đó là hoa
; thì in ra màn hình, nếu chữ đó là thường thì chuyển thành chữ hoa và
; in ra màn hình 
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

        SUB AL,20h

        _PRINT:
            MOV char,AL
            MOV AH,9
            LEA DX,msg2
            INT 21h
            MOV AH,2
            MOV DL,char
            INT 21h
            JMP _EXIT

        _ERROR:
            MOV AH,9
            LEA DX,msg1
            INT 21h

        _EXIT:
        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
