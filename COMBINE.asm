; [+] Loading Matrices
ORG 0A0H
MATRIXA: DB 1,2,3,4,5,6,7,8,9
ORG 0B0H
MATRIXB: DB 1,2,3,4,5,6,7,8,9
ORG 0C0H
TRANSPO_MATRIX: DB 0,3,6,1,4,7,2,5,8

; [+] STARTING THE PROGRAM
ORG 0H

; Hamard Division


MOV R5, #0A0H        ; Start at memory address 50h (first set)
MOV R6, #0B0H        ; Start at memory address 59h (second set)


MOV R2, #09H
MOV R0,#0B0h
LOOP4:

    MOV A,R5
    MOVC A,@A+DPTR
    MOV R3,A

    MOV A,R6
    MOVC A,@A+DPTR
    
    MOV B, R3       
    DIV AB           ; Add the corresponding number from the second set
    MOV @R0, A       ; Store the result in the result set
    INC R0           ; Move to the next memory address in the first set
    INC R1           ; Move to the next memory address in the second set
    INC R5
    INC R6
    DJNZ R2, LOOP4   ; Repeat until 9 numbers are added


; A Transpose 


MOV R0, #0E8H
MOV R5,#08H
MOV R6,#09H
LOOP5:
   MOV A,R5
   MOV DPTR, #0C0H
   MOVC A,@A+DPTR
   MOV DPTR, #0A0H
   MOVC A,@A+DPTR
   MOV @R0, A
   DEC R0
   DEC R5
   DJNZ R6, LOOP5
   
;SUMMATION
MOV DPTR, #0H

; Add the first and second set of numbers and store the result
MOV R5, #0A0H        ; Start at memory address 50h (first set)
MOV R6, #0B0H        ; Start at memory address 59h (second set)


MOV R2, #09H
MOV R0,#30h
LOOP2:

    MOV A,R5 ; Jumping to R5 Address #60h
    MOVC A,@A+DPTR ; Return to DPTR initial address #0h
    MOV R3,A

    MOV A,R6         ;
    MOVC A,@A+DPTR   
           
    ADD A, R3       ; Add the corresponding number from the second set
    MOV @R0, A       ; Store the result in the result set
    INC R0           ; Move to the next memory address in the first set
    INC R1           ; Move to the next memory address in the second set
    INC R5
    INC R6
    DJNZ R2, LOOP2   ; Repeat until 9 numbers are added
    
;DIFFERENCE


; Add the first and second set of numbers and store the result
MOV R5, #0A0H        ; Start at memory address 50h (first set)
MOV R6, #0B0H        ; Start at memory address 59h (second set)


MOV R2, #09H
MOV R0,#60h
LOOP:

    MOV A,R5
    MOVC A,@A+DPTR
    MOV R3,A

    MOV A,R6
    MOVC A,@A+DPTR
           
    SUBB A, R3       ; Add the corresponding number from the second set
    MOV @R0, A       ; Store the result in the result set
    INC R0           ; Move to the next memory address in the first set
    INC R1           ; Move to the next memory address in the second set
    INC R5
    INC R6
    DJNZ R2, LOOP   ; Repeat until 9 numbers are added
    
; Hamard Product
MOV DPTR, #0H

MOV R5, #0A0H        ; Start at memory address 50h (first set)
MOV R6, #0B0H        ; Start at memory address 59h (second set)


MOV R2, #09H
MOV R0,#90h
LOOP3:

    MOV A,R5
    MOVC A,@A+DPTR
    MOV R3,A

    MOV A,R6
    MOVC A,@A+DPTR
    
    MOV B, R3       
    MUL AB           ; Add the corresponding number from the second set
    MOV @R0, A       ; Store the result in the result set
    INC R0           ; Move to the next memory address in the first set
    INC R1           ; Move to the next memory address in the second set
    INC R5
    INC R6
    DJNZ R2, LOOP3   ; Repeat until 9 numbers are added
    

    
; A Transpose 


MOV R0, #0F8H
MOV R5,#08H
MOV R6,#09H
LOOP9:
   MOV A,R5
   MOV DPTR, #0C0H
   MOVC A,@A+DPTR
   MOV DPTR, #0B0H
   MOVC A,@A+DPTR
   MOV @R0, A
   DEC R0
   DEC R5
   DJNZ R6, LOOP9
END