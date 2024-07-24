; [+] Loading Matrices
ORG 60H
MATRIXA: DB 1,2,3,4,5,6,7,8,9
ORG 70H
MATRIXB: DB 1,2,3,4,5,6,7,8,9
ORG 80H
TRANSPO_MATRIX: DB 0,3,6,1,4,7,2,5,8
; [+] STARTING THE PROGRAM
ORG 0H

    
; Hamard Division
MOV DPTR, #0H

MOV R5, #60H        ; Start at memory address 50h (first set)
MOV R6, #70H        ; Start at memory address 59h (second set)


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
END