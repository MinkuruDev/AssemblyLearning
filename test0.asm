.model SMALL

.stack 100h

.data
    ; msg DB "Hello World!$"
    ENTER   EQU     0Dh,0Ah
    _name   DB      "Nguyen Trung Vinh$"
    class   DB      ENTER,"B15D52$"

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        LEA DX,_name
        MOV AH,9
        INT 21h   
        
        LEA DX,class
        MOV AH,9
        INT 21h

        MOV AH,4CH
        INT 21h
    main ENDP
    END main
