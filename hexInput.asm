.model SMALL

.stack 100h

.data
    ENTER   EQU     0Dh,0Ah
    msg     DB      "Nhap vao so thap luc phan: $"
    msg1    DB      ENTER,"Nhap lai: $"
    msg2    DB      ENTER,"So da nhap: $"
    arr     DB      100h DUP (?)

.code
    main PROC
        ; init 
        MOV AX,@data
        MOV DS,AX

        ; output msg / a string
        LEA DX,msg
        MOV AH,9
        INT 21h
        LEA SI,arr
        MOV CX,0
        JMP _WHILE_INPUT

        _WRONG_INPUT:
            LEA DX,msg1
            MOV AH,9
            INT 21h
            LEA SI,arr
            MOV CX,0
        
        _WHILE_INPUT:
            MOV AH,1
            INT 21h

            CMP AL,0Dh
            JE _END_INPUT

            CMP AL,'0'
            JL _WRONG_INPUT
            CMP AL,'9'
            JLE _PROCESS

            CMP AL,'A'
            JL _WRONG_INPUT
            CMP AL,'F'
            JLE _PROCESS

            CMP AL,'a'
            JL _WRONG_INPUT
            CMP AL,'f'
            JG _WRONG_INPUT

            _PROCESS:
                ; mask where number still number
                ; lowercase still lowercase
                ; uppercase become lowercase
                OR AL,00100000b
                MOV [SI],AL
                INC CX
                INC SI
                JMP _WHILE_INPUT
            
        _END_INPUT:

        LEA DX,msg2
        MOV AH,9
        INT 21h

        LEA SI,arr
        MOV BX,0

        _WHILE_PRINT:
            CMP BX,CX
            JE _END_PRINT

            MOV AH,2
            MOV DL,[SI]
            INT 21h
            INC BX
            INC SI
            JMP _WHILE_PRINT

        _END_PRINT:

        ; exit
        MOV AH,4CH
        INT 21h
    main ENDP
    END main
