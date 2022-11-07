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

        ; init first loop
        MOV CH,10
        MOV AH,2

        _START_LOOP1:
            MOV CL,10
            MOV DL,'@'
            _START_LOOP2:
                INT 21h

                DEC CL
                JNZ _START_LOOP2
            
            MOV DL,0Dh
            INT 21h
            MOV DL,0Ah
            INT 21h

            DEC CH
            JNZ _START_LOOP1

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
