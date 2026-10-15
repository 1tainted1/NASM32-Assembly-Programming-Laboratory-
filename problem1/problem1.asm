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

male db "Hello", 10
male_len equ $ - male

female db "World", 10
female_len equ $ - female

invalid db "Invalid", 10
invalid_len equ $ - invalid

section .bss
    n resb 100
    a resb 100
    g resb 100

    n_len resd 1
    a_len resd 1
    g_len resd 1

section .text
    global _start

_start:
    mov ecx, name
    mov edx, name_len
    call printString
    mov ecx, n
    mov edx, 100
    call readString
    mov [n_len], eax

    mov ecx, gender
    mov edx, gender_len
    call printString
    mov ecx, g
    mov edx, 100
    call readString
    mov [g_len], eax

    mov ecx, age
    mov edx, age_len
    call printString
    mov ecx, a
    mov edx, 100
    call readString
    dec eax
    mov [a_len], eax

    mov ecx, hello
    mov edx, hello_len
    call printString
    mov ecx, n
    mov edx, [n_len]
    call printString

    mov ecx, greet1
    mov edx, greet1_len
    call printString
    mov ecx, a
    mov edx, [a_len]
    call printString
    mov ecx, greet2
    mov edx, greet2_len
    call printString

    call genderequivalent

    mov eax, 1
    xor ebx, ebx
    int 0x80

genderequivalent:
    mov al, [g]

    cmp al, 'M'
    je printMale

    cmp al, 'm'
    je printMale

    cmp al, 'F'
    je printFemale

    cmp al, 'f'
    je printFemale

    mov ecx, invalid
    mov edx, invalid_len
    call printString
    ret

printFemale:
    mov ecx, female
    mov edx, female_len
    call printString
    ret

printMale:
    mov ecx, male
    mov edx, male_len
    call printString
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