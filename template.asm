.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Hello World!$"
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

        ; input a char, store in char
        MOV AH,1
        INT 21h
        MOV char,AL

        ; output a char
        MOV AH,2
        MOV DL,char
        INT 21h

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
