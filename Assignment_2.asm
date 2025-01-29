Define two ASCII numbers in data segment. Then, sum the numbers first while
converting the numbers first to,
a. Unpacked BCD
b. Packed BCD
data segment
 data1 db '4936'
 data2 db '10$'
 data3 db ?
ends
code segment
start:
 mov ax, @data
 mov ds, ax

 mov cx, 4
 mov bx, 0
 AGAIN_UNPACKED:
 mov al, data1[bx]
 and al, 0fh
 mov data2[bx], al
 inc bx
 loop AGAIN_UNPACKED
 mov bx, 0
 mov dl, 0
 mov cx, 4
 AGAIN_SUM:
 mov al, data2[bx]
 add al, data2[bx+4]
 add al, dl
 daa
 mov data3[bx], al
 mov dl, ah
 inc bx
 loop AGAIN_SUM

 mov ah, 09h
 lea dx, data3
 int 21h
 mov ah, 4Ch
 int 21h
end start

Define 2 numbers in decimal 50 and 100 in data segment. Perform signed
arithmethic and observe the changes in OF Flag. Avoid the erroneous result with
CBW.
data segment
data1 db +50
data2 db +100
result dw ?
ends
code segment
start:
mov ax, data
mov ds, ax
mov es, ax ; data1 AL UPTADE
sub ah, ah
mov al, data1
mov bl, data2
add al, bl
jno again
mov al, data2
cbw
mov bx, ax
mov al, data1
cbw
add ax, bx
again: mov result, ax
mov ax, 4c00h
int 21h
ends
end start;

Define 2 negative numbers in decimal -50 and -100 in data segment. Sum the
numbers and observe the changes in OF Flag. Avoid the erroneous result with
CBW.

data segment
data1 db -50
data2 db -100
result dw ?
ends
code segment
start:
mov ax, data
mov ds, ax
mov es, ax ; data1 AL UPTADE
sub ah, ah
mov al, data1
mov bl, data2
add al, bl
jno again
mov al, data2
cbw
mov bx, ax
mov al, data1
cbw
add ax, bx
again: mov result, ax
mov ax, 4c00h
int 21h
ends
end start;

Define a memory location and store “This is CE342 Lab” there. Write a program
to read this data and convert each character to upper case if and only it is
lowercase. The new data must be stored in a location labelled “Uppercase”.
Finally, copy the new string to extra segment using string operations.
Hint: The difference between a lower case and an uppercase letter is bit D5. For
example, “a” is 61H (0110 0001) whereas “A” is 41H (0100 0001). This is true for
all letters.
data segment
msg db 'This is CE342 Lab'
new db 17 dup(?)
ends
stack segment
dw 128 dup(0)
ends
code segment
start:
; set segment registers:
mov ax, @data
mov ds, ax
mov ss, ax
mov si, offset msg
mov di, offset new
mov cx, 17
JUMP: cmp [si], 'a'
sub [si], ' '
dec cx
JNZ JUMP
mov dx, offset new
mov ah, 09
int 21h
mov ax, 4c00h
int 21h
ends
end start ;