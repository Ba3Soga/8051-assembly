ORG 701H
MATRIXA1: DB 162, 19, 3
ORG 711H
MATRIXA2: DB  81, 2, 32
ORG 721H
MATRIXA3: DB 35, 180, 23


ORG 741H
MATRIXB1: DB 97, 36, 62
ORG 751H
MATRIXB2: DB  4, 125, 243
ORG 761H
MATRIXB3: DB 72,100,227

ORG 0H

;INITIALIZATIONS
START:
    MOV R2,#1H ; MATRICES INDIXER
    ;MOV R4,#52H
    
    MOV DPTR,#0H ; EXTERNAL RAM POINTER
    
    MOV R0, #91H ; INTERNAL RAM POINTER
    
    CLR A	     ; CLEAR A
    
    mov R1, #0H
    MOV R7,#3H
    MOV R3,#3H
    
    MOV R4,#0H ;ROW SWITCHER
    MOV R5,#3H ; LOOP2 COUNTER
    MOV R6,#3H ; LOOP1 COUNTER    

Switch:
    MOV DPTR, #0FF02H
    MOVX A, @DPTR
    CJNE A, #00,  SUMMATION	; if A=0, go to part (Clear)
    
CLEAR:
LOOP00:
    LOOP0:
        MOV A,#00H
        ACALL STORE
      
        DJNZ R5, LOOP0        
   MOV R5,#3H
   DEC R6
   DJNZ R6, LOOP00
   SJMP $

    
; SUMMATION: A + B
SUMMATION:
CJNE A, #03,  DIFFERENCE	; 011 SUMMATION
lOOP7:

    LOOP6:
        
        MOV DPTR,#700H
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        MOV A,R2
        MOVC A,@A+DPTR
        
        MOV B,A

        
        MOV DPTR,#740H  
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        
        MOV A,R2
        MOVC A,@A+DPTR
        MOV DPTR,#0H
        
        ADD A, B
        
        ACALL  STORE
        
        INC R2
        DJNZ R5, LOOP6
    
    MOV DPTR,#0H
    
    MOV A,R4
    ADD A,#10H
    MOV R4,A
    
    MOV R5, #3H
    MOV R2, #1H
    DJNZ R6, LOOP7
    SJMP $


; DIFFERENCE: A - B
DIFFERENCE:
CJNE A, #04,  HADAMARD_PRODUCT	; 100 DIFFERENCE
lOOP3:

    LOOP4:
        
        MOV DPTR,#700H
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        MOV A,R2
        MOVC A,@A+DPTR
        
        MOV B,A

        
        MOV DPTR,#740H  
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        
        MOV A,R2
        MOVC A,@A+DPTR
        MOV DPTR,#0H
        
        SUBB A, B
        
        ACALL  STORE
        
        INC R2
        DJNZ R5, LOOP4
    
    MOV DPTR,#0H
    
    MOV A,R4
    ADD A,#10H
    MOV R4,A
    
    MOV R5, #3H
    MOV R2, #1H
    DJNZ R6, LOOP3
    SJMP $
      
TT:
MOV A,R0
SUBB A,#3H
ADD A,#10H

MOV R0,A
MOV A,R1
MOV @R0,A
MOV R7,#2H
INC R0

RET 

; HADAMARD DIVISION: A * B
HADAMARD_PRODUCT:
CJNE A, #05,  HADAMARD_DIVISION	; 101 HADAMARD_PRODUCT
lOOP8:

    LOOP9:
        
        MOV DPTR,#700H
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        MOV A,R2
        MOVC A,@A+DPTR
        
        MOV B,A

        
        MOV DPTR,#740H  
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        
        MOV A,R2
        MOVC A,@A+DPTR
        MOV DPTR,#0H
        
        MUL AB
        
        ACALL  STORE
        
        INC R2
        DJNZ R5, LOOP9
    
    MOV DPTR,#0H
    
    MOV A,R4
    ADD A,#10H
    MOV R4,A
    
    MOV R5, #3H
    MOV R2, #1H
    DJNZ R6, LOOP8
    SJMP $
    


; HADAMARD DIVISION A / B
HADAMARD_DIVISION:
CJNE A, #07,  END_END	; 111 HADAMARD DIVISION
lOOP1:

    LOOP2:
        
        MOV DPTR,#740H  
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        MOV A,R2
        MOVC A,@A+DPTR
        
        MOV B,A

        MOV DPTR,#700H
        MOV A, DPL
        ADD A, R4
        MOV DPL,A
        
        
        
        MOV A,R2
        MOVC A,@A+DPTR
        MOV DPTR,#0H
        
        DIV AB
        
        ACALL  STORE
        
        INC R2
        DJNZ R5, LOOP2
    
    MOV DPTR,#0H
    
    MOV A,R4
    ADD A,#10H
    MOV R4,A
    
    MOV R5, #3H
    MOV R2, #1H
    DJNZ R6, LOOP1
    SJMP $
    

    
STORE:
    MOV R1, A
    MOV A,R7
    JZ TT
    MOV A,R1
    MOV @R0, A
    INC R0
    DEC R7
    RET 
    







END_END:

END