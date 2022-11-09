.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg1    DB      "Nhap vao hai ky tu: $"
    msg2    DB      ENTER,"Ky tu nho hon la: $"
    char1   DB      ?
    char2   DB      ?

; ĐỀ BÀI
;
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
; Nhập vào 2 ký tự, in ra ký tự nhỏ hơn theo mã ASCII
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
        LEA DX,msg1
        MOV AH,9
        INT 21h

        ; input a char, store in char
        MOV AH,1
        INT 21h
        MOV char1,AL
        INT 21h
        MOV char2,AL

        ; output msg2
        LEA DX,msg2
        MOV AH,9
        INT 21h

        MOV DL,char1 ; char 1 smaller
        CMP DL,char2 
            JNA _END_IF ; if char1<char2 _END_IF 
            MOV DL,char2 ; if char 2 is smaller, assign to DL
        _END_IF:
        MOV AH,2
        INT 21h

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
