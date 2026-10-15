section .data

name db "Enter student name: "
name_len equ $ - name

id db "Enter student ID: "
id_len equ $ - id

grade db "Enter grade: "
grade_len equ $ - grade

stu_name db "Student name: "
stu_name_len equ $ - stu_name

stu_id db "Student ID: "
stu_id_len equ $ - stu_id

stu_grade db "Grade: "
stu_grade_len equ $ - stu_grade

classification db "Classification: "
classification_len equ $ - classification

e db "Excellent", 10
e_len equ $ - e

vg db "Very Good", 10
vg_len equ $ - vg

g db "Good", 10
g_len equ $ - g

p db "Passed", 10
p_len equ $ - p

f db "Failed", 10
f_len equ $ - f

invalid db "INVALID GRADE", 10
invalid_len equ $ - invalid

section .bss
    n resb 100
    id_res resb 100
    gr resb 100

    n_len resd 1
    id_res_len resd 1
    gr_len resd 1

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

    mov ecx, id
    mov edx, id_len
    call printString
    mov ecx, id_res
    mov edx, 100
    call readString
    mov [id_res_len], eax

    mov ecx, grade
    mov edx, grade_len
    call printString
    mov ecx, gr
    mov edx, 100
    call readString
    mov [gr_len], eax

    mov ecx, stu_name
    mov edx, stu_name_len
    call printString
    mov ecx, n
    mov edx, [n_len]
    call printString

    mov ecx, stu_id
    mov edx, stu_id_len
    call printString
    mov ecx, id_res
    mov edx, [id_res_len]
    call printString
    
    mov ecx, stu_grade
    mov edx, stu_grade_len
    call printString
    mov ecx, gr
    mov edx, [gr_len]
    call printString

    mov ecx, classification
    mov edx, classification_len
    call printString

    call classifyGrade

    mov eax, 1
    xor ebx, ebx
    int 0x80

classifyGrade:
    mov ecx, 0
    mov ebx, 0

convert_to_num_loop:
    cmp ecx, [gr_len]
    jge checking
    mov al, [gr + ecx]
    cmp al, 10
    je checking
    cmp al, '0'
    jl invalid_grade
    cmp al, '9'
    jg invalid_grade
    sub al, '0'
    movzx eax, al
    imul ebx, ebx, 10
    add ebx, eax
    inc ecx
    jmp convert_to_num_loop

checking:
    cmp ebx, 100
    jg invalid_grade
    cmp ebx, 90
    jge print_e
    cmp ebx, 85
    jge print_vg
    cmp ebx, 80
    jge print_g
    cmp ebx, 75
    jge print_p
    jmp print_f

print_e:
    mov ecx, e
    mov edx, e_len
    call printString
    ret

print_vg:
    mov ecx, vg
    mov edx, vg_len
    call printString
    ret

print_g:
    mov ecx, g
    mov edx, g_len
    call printString
    ret

print_p:
    mov ecx, p
    mov edx, p_len
    call printString
    ret

print_f:
    mov ecx, f
    mov edx, f_len
    call printString
    ret

invalid_grade:
    mov ecx, invalid
    mov edx, invalid_len
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