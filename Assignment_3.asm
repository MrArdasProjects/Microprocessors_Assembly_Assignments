Write a program that includes 4 (four) macros performing the following functions using INT 10
and INT 21 functions:
a) Two macros should use INT 10 functions to clear the screen and set the cursor position.
b) Two macros should use INT 21 functions, one to read a character and the other to read a
string (up to 10 characters) from keyboard and display them on the screen. The string
should be displayed on the next line.
SET_CURSOR MACRO ROW, COL
 MOV AH, 02h
 MOV BH, 0
 MOV DH, ROW
 MOV DL, COL
 INT 10h
ENDM
READ_CHAR MACRO
 MOV AH, 01h
 INT 21h
ENDM
READ_STRING MACRO
 MOV AH, 0Ah
 MOV DX, OFFSET BUFFER
 INT 21h
 MOV AH, 09h
 MOV DX, OFFSET BUFFER+2
 INT 21h
ENDM
BUFFER DB 12 DUP ('$')
.MODEL SMALL
.STACK 100h
.DATA
 MSG DB 'Enter a character: $'
.CODE
MAIN PROC
 SET_CURSOR 1, 1
 MOV AH, 09h
 MOV DX, OFFSET MSG
 INT 21h

 READ_STRING


 MOV AH, 02h
 MOV DL, BUFFER+2
 INT 21h

 MOV AH, 01h
 INT 21h

 MOV AH, 4Ch
 INT 21h
MAIN ENDP
END MAIN

Write an assembly program that fulfills the following steps:
a) You are going to ask the user which course ID is he/she taking.
b) You are going to read the course ID from the console screen as a string input.
c) You are going to ask the user which semester is he/she currently in.
d) You are going to read the semester number from console screen as a digit input.
e) You are going to clear the console screen.
f) You are going to set your cursor position in the middle of the screen.
g) You are going to print course ID.
h) You are going to print semester number.
You may use the below data segment content in your program.
.DATA
MESSAGE1 DB ‘Please input your course ID: $’
MESSAGE2 DB ‘Please input your current semester: $’
COURSE_ID DB 6, ?, 6 DUP (‘$’)
SEMESTER_NO DB 2,?, dup(0)
NEWLINE DB 0DH, 0AH,'$

; multi-segment executable file template.
data segment
 ; add your data here!
 MESSAGE1 DB 'Please input your course ID: $'
 MESSAGE2 DB 'Please input your current semester: $'
 COURSE_ID DB 6, ?, 6 DUP ('$')
 SEMESTER_NO DB 2,?, dup(0)
 NEWLINE DB 0DH, 0AH,'$'
ends
stack segment
 dw 128 dup(0)
ends
code segment
start:


clear_screen macro
 MOV AX, 0600H
MOV BH, 07H
MOV CX, 0000H
MOV DX, 184FH
INT 10H
endm
set_cursor macro row, col
 mov ah, 02h
 mov bh, 0
 mov dh, row
 mov dl, col
 int 10h
endm
read_char macro
 mov ah, 01h
 int 21h
endm
read_string macro buffer
 mov ah, 0Ah
 mov dx, offset buffer
 int 21h
endm
main:
 mov ax, data
 mov ds, ax
 mov es, ax
 clear_screen
 set_cursor 0, 1

 ; a) Asking the user for course ID
 mov ah, 09h
 mov dx, offset MESSAGE1
 int 21h

 ; b) Reading course ID from the console screen as a string input
 mov ah, 0Ah
 mov dx, offset COURSE_ID
 int 21h

 ; Newline after reading course ID
 mov ah, 09h
 mov dx, offset NEWLINE
 int 21h

set_cursor 1, 1

; c) Asking the user for current semester
 mov ah, 09h
 mov dx, offset MESSAGE2
 int 21h

 ; d) Reading semester number from console screen as a digit input
 mov ah, 01h
 int 21h
 mov [SEMESTER_NO + 1], al


 mov ah, 09h
 mov dx, offset NEWLINE
 int 21h

 ; e) Clearing the console screen
 clear_screen

 ; f) Setting cursor position in the middle of the screen
 set_cursor 10,40

 ; g) Printing course ID
 mov ah, 09h
 mov dx, offset COURSE_ID + 2
 int 21h
 set_cursor 11,40
 ; h) Printing semester number
 mov ah, 02h
 mov dl, [SEMESTER_NO + 1]
 int 21h

 mov ax, 4c00h
 int 21h
ends
end start