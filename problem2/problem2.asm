section .data

name db "What is your name? "
name_len equ $ - name

age db "How old are you? "
age_len equ $ - age

level db "What is your year level? ", 10
level_len equ $ - level

hello db "Hello! "
hello_len equ $ - hello 

greet1 db "You are "
greet1_len equ $ - greet1

greet2 db " years old", 10
greet2_len equ $ - greet2

f db "freshman", 10
f_len equ $ - f

so db "sophomore", 10
so_len equ $ - so

j db "junior", 10
j_len equ $ - j

se db "senior", 10
se_len equ $ - se

section .bss
    n resb 10
    a resb 10
    l resb 10

section .text
    global _start

_start:
    mov ecx, name
    mov edx, name_len
    call printString
    mov ecx, n
    mov edx, 10
    call readString

    mov ecx, age
    mov edx, age_len
    call printString
    mov ecx, a
    mov edx, 10
    call readString

    mov ecx, level
    mov edx, level_len
    call printString
    mov ecx, l
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

    call yearequivalent

    mov eax, 1
    xor ebx, ebx
    int 0x80

yearequivalent:
    mov al, [l]

    cmp al, '1'
    je printF

    cmp al, '2'
    je printSo

    cmp al, '3'
    je printJ

    cmp al, '4'
    je printSe

printF:
    mov ecx, f
    mov edx, f_len
    call printString
    int 0x80
    ret

printSo:
    mov ecx, so
    mov edx, so_len
    call printString
    int 0x80
    ret

printSe:
    mov ecx, se
    mov edx, se_len
    call printString
    int 0x80
    ret

printJ:
    mov ecx, j
    mov edx, j_len
    call printString
    int 0x80
    ret

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