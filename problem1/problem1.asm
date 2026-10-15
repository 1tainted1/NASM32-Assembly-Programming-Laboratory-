section .data

name db "What is your name? "
name_len equ $ - name

age db "How old are you? "
age_len equ $ - age

gender db "What is your gender? "
gender_len equ $ - gender

hello db "Hello! "
hello_len equ $ - hello

greet1 db "You are "
greet1_len equ $ - greet1

greet2 db " years old", 10
greet2_len equ $ - greet2

section .bss
    n resb 10
    a resb 10
    g resb 10

section .text
    global _start

_start:
    mov ecx, name
    mov edx, name_len
    call printString
    mov ecx, n
    mov edx, 10
    call readString

    mov ecx, gender
    mov edx, gender_len
    call printString
    mov ecx, g
    mov edx, 10
    call readString

    mov ecx, age
    mov edx, age_len
    call printString
    mov ecx, a
    mov edx, 10
    call readString

    mov ecx, hello
    mov edx, hello_len
    call printString
    mov ecx, n
    mov edx, 10
    call printString

    mov ecx, greet1
    mov edx, greet1_len
    call printString
    mov ecx, a
    mov edx, 10
    call printString
    mov ecx, greet2
    mov edx, greet2_len
    call printString

printString: 
    mov eax, 4 
    mov ebx, 1 
    int 0x80 
    ret

readString: 
    mov eax, 3 
    mov ebx, 0 
    int 0x80 
    ret