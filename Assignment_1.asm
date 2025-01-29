
;1.	Write an assembly program to perform following operations: 
;
;a)	Find the lowest value while summing the sequence of numbers which is located in the given array. 

.DATA 
SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39 
LOWEST DB ? 
SUM db ?

data segment
    SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39 
    LOWEST DB ? 
    SUM db ? 
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    sub ax, ax
    sub bx, bx
    sub dx, dx
    mov si, offset signed_data
    mov bl, [si]
    
    tdi:
    sub ax, ax
    mov al, [si]
    cmp al, bl
    handle:
    cbw
    add dx, ax
    inc si
    cmp si, 9
    jge final
    jmp tdi
    swp:
    cbw
    mov bx, ax
    jmp handle
    final:
    mov offset lowest, bx
    mov offset sum, dx
    
    
    mov ax, 4c00H
    int 21h
    
ends

end start


b)	Find the average value of the same array. 

.DATA 
SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39 
SUM DB ? 
AVERAGE DB ? 

.MODEL SMALL
.STACK 100H
.DATA
SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39
LOWEST DB ?
SUM DB ?
AVERAGE DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 9
    MOV SI, OFFSET SIGNED_DATA
    MOV BL, 0FFH
    MOV SUM, 0
FIND_LOWEST:
    MOV AL, [SI]
    ADD SUM, AL
    CMP AL, BL
    JL UPDATE_LOWEST
    INC SI
    LOOP FIND_LOWEST

UPDATE_LOWEST:
    MOV BL, AL
    MOV LOWEST, BL

    MOV AL, SUM
    CBW
    IDIV CX
    MOV AVERAGE, AL

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


c)	Let’s assume that we add -99 at the end of this array. Now, write an assembly program or extend your previous assembly program so that you can compute sum and the average of the array below. 

.DATA 
SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39, -99 
SUM DW ?
	.MODEL SMALL
.STACK 100H
.DATA
SIGNED_DATA DB +25, -78, -95, +22, -69, +25, -85, +47, -39, -99
SUM DW ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 10
    MOV SI, OFFSET SIGNED_DATA
    MOV BX, 0
    XOR AX, AX
SUM_LOOP:
    MOV AL, [SI]
    ADD BX, AX
    INC SI
    LOOP SUM_LOOP

    MOV AX, BX
    CBW
    IDIV CX
    MOV SUM, AX

    MOV AH, 4CH
    INT 21H
MAIN ENDP

END MAIN

2.	Write an assembly program that decides whether two strings are completely matched or not. You may use the strings below to test in your code. You should report the result of the matching as true or false (true = 1 or T, false = 0 or F in RESULT). 

Example:

.DATA 
INPUT1 DB ‘COLOR$’ 
INPUT2 DB ‘COLOUR$’ 
RESULT DB ?

MODEL SMALL
.STACK 100H
.DATA
INPUT1 DB 'COLOR$'
INPUT2 DB 'COLOUR$'
RESULT DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV SI, OFFSET INPUT1
    MOV DI, OFFSET INPUT2

COMPARE_STRINGS:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_COMPARE
    MOV BL, [DI]
    CMP BL, '$'
    JE END_COMPARE
    CMP AL, BL
    JNE STRINGS_DIFFERENT
    INC SI
    INC DI
    JMP COMPARE_STRINGS

STRINGS_DIFFERENT:
    MOV RESULT, '0'
    JMP END_PROGRAM

END_COMPARE:
    MOV RESULT, '1'

END_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

END MAIN



3.	Write a program to encode a given text. Caesar’s algorithm, which is based on shifting the characters of the alphabet by a fixed number should be used to encode the given plain text.
You should create a table with the alphabet shifted by a certain integer value (e.g., 4) and replace the letter in your sentence with the  corresponding letter in your shifted alphabet. 

Example
Actual alphabet   “abcdefghijklmnopqrstuvwxyz ”
code alphabet     “ efghijklmnopqrstuvwxyz abcd”  (shifted by 4)
Actual sentence “computer engineering”
Coded sentence “gsqtyxivirkmriivmrk”

Note: if you leave a space between words, you should also include a space in your alphabet.

.model small
.stack 100h
.data
    input_text db "computer engineering$"
    shift db 4
    encoded_text db 100 dup('$')

.code
main:
    mov ax, @data
    mov ds, ax
    
    lea si, input_text
    lea di, encoded_text
    mov bl, [shift]

encode_loop:
    mov al, [si]
    cmp al, '$'
    je end_encoding
    cmp al, ' '
    je skip_encoding
    cmp al, 'a'
    jl skip_encoding
    cmp al, 'z'
    jg skip_encoding
    sub al, 'a'
    add al, bl
    and al, 1Fh
    add al, 'a'
    jmp store_char

skip_encoding:
    mov [di], al

store_char:
    mov [di], al
    inc si
    inc di
    jmp encode_loop

end_encoding:
    mov byte [di], '$'

    lea dx, encoded_text
    mov ah, 9
    int 21h
    mov ax, 4C00h
    int 21h

end main




