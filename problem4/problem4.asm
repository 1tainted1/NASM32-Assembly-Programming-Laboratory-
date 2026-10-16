section .data

name db "Enter account name: "
name_len equ $ - name

pin db "Enter PIN: "
pin_len equ $ - pin

with db "Enter withdrawal amount: "
with_len equ $ - with

curr_bal db "Current Balance: PHP10000"
curr_bal_len equ $ - curr_bal

granted db "ACCESS GRANTED", 10
granted_len equ $ - granted

denied db "ACCESS DENIED", 10
denied_len equ $ - denied

if db "INSUFFICIENT FUNDS", 10
if_len equ $ - if

multiple db "AMOUNT MUST BE A MULTIPLE OF 100", 10
multiple_len equ $ - multiple

inv_amount db "INVALID AMOUNT"
inv_amount_len equ $ - inv_amount

bal dd 10000
bal_len equ $ - bal

pin dd "1234"
pin_len equ $ - pin

section .bss
    n resb 100
    p resb 100
    with_amount resb 100

    n_len resd 25
    p_res_len resd 25
    with_amount resd 25

section .text
    global _start

_start:

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