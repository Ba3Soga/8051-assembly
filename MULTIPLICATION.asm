ORG 400H
MATRIXA: DB 4, 6,8, 1, 3, 6,9, 3, 2
ORG 410H
MATRIXB: DB 2, 4, 7, 4, 5, 7, 3, 1, 1
ORG 420H
MATRIXC: DB 1, 3, 4,8, 7,5, 3, 8,9
ORG 430H
RESULT: DB 0, 0, 0, 0, 0, 0, 0, 0, 0
ORG 440H
SIGR: DB 0, 0, 0, 0, 0, 0, 0, 0, 0
ORG 00H
MOV R2,#3 ; counter for looping every row in MATRIXB
LOOP1:
MOV R1,#3 ; counter for looping every column in MATRIXC
LOOP2:
CLR C ; genrate pointer to MATRIXC
MOV A,#3
SUBB A,R1
MOV R4,A
CLR C ; genrate pointer to MATRIXB
MOV A,#3
SUBB A,R2
MOV B,#3
MUL AB
MOV R3,A
MOV R0,#3 ; counter for b[i,j]*c[i,j]
MOV R5,#0 ; sum of b[i,j]*c[i,j]
LOOP3:
MOV DPTR, #MATRIXB ; load b[i,j]
MOV A,R3
MOVC A,@A+DPTR
MOV B,A
MOV DPTR, #MATRIXC ; load c[i,j]
MOV A,R4
MOVC A,@A+DPTR
MUL AB ; b[i,j]*c[i,j]
ADD A,R5 ; calculate sum of b[i,j]*c[i,j]
MOV R5,A ; store the sum
INC R3 ; point to next b[i,j]
MOV A,R4 ; point to next c[i,j]
ADD A,#3
MOV R4,A
DJNZ R0,LOOP3
DJNZ R1,LOOP2
DJNZ R2,LOOP1
END