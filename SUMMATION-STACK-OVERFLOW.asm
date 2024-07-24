; [+] Loading Matrices
ORG 60H
MATRIXA: DB 162, 19, 3, 81, 2, 32, 35, 180, 23
ORG 70H
MATRIXB: DB 97, 36, 62, 4, 125, 243,72,100,227

; [+] STARTING THE PROGRAM
ORG 0H



;SUMMATION
MOV DPTR, #0H

; Add the first and second set of numbers and store the result
MOV R5, #60H        ; Start at memory address 50h (first set)
MOV R6, #70H        ; Start at memory address 59h (second set)


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
END