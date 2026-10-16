section .data
    name db "Enter account name: "
    name_len equ $ - name

    pin db "Enter PIN: "
    pin_len equ $ - pin

    with db "Enter withdrawal amount: "
    with_len equ $ - with

    curr_bal db "Current Balance: PHP 10000", 10
    curr_bal_len equ $ - curr_bal

    granted db "ACCESS GRANTED", 10
    granted_len equ $ - granted

    denied db "ACCESS DENIED", 10
    denied_len equ $ - denied

    success db "WITHDRAWAL SUCCESSFUL", 10
    success_len equ $ - success

    withdrawn db "Amount Withdrawn: PHP "
    withdrawn_len equ $ - withdrawn

    remaining db "Remaining Balance: PHP "
    remaining_len equ $ - remaining

    insuff db "INSUFFICIENT FUNDS", 10
    insuff_len equ $ - insuff

    multiple db "AMOUNT MUST BE A MULTIPLE OF 100", 10
    multiple_len equ $ - multiple

    inv_amount db "INVALID AMOUNT", 10
    inv_amount_len equ $ - inv_amount

section .bss
    n resb 100
    p resb 100
    w resb 100
    numbuf resb 16

    n_len resd 1
    p_res_len resd 1
    with_amount resd 1
    balance resd 1
    amount resd 1

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

    mov ecx, pin
    mov edx, pin_len
    call printString
    mov ecx, p
    mov edx, 100
    call readString
    mov [p_res_len], eax

    call checkPin

    mov eax, 1
    xor ebx, ebx
    int 0x80

checkPin:
    cmp dword [p_res_len], 5
    jne pinBad

    mov al, [p]
    cmp al, '1'
    jne pinBad

    mov al, [p + 1]
    cmp al, '2'
    jne pinBad

    mov al, [p + 2]
    cmp al, '3'
    jne pinBad

    mov al, [p + 3]
    cmp al, '4'
    jne pinBad

    jmp pinGood

pinBad:
    mov ecx, denied
    mov edx, denied_len
    call printString
    ret

pinGood:
    mov ecx, granted
    mov edx, granted_len
    call printString

    mov dword [balance], 10000

    mov ecx, curr_bal
    mov edx, curr_bal_len
    call printString

    mov ecx, with
    mov edx, with_len
    call printString
    mov ecx, w
    mov edx, 100
    call readString
    mov [with_amount], eax

    call processAmount
    ret

processAmount:
    call textToNum

    cmp eax, -1
    je badAmount

    cmp eax, 0
    jle badAmount

    mov [amount], eax

    mov ebx, [balance]
    cmp eax, ebx
    jg notEnough

    mov eax, [amount]
    mov ebx, 100
    xor edx, edx
    div ebx
    cmp edx, 0
    jne notMultiple

    mov eax, [balance]
    mov ebx, [amount]
    sub eax, ebx
    mov [balance], eax

    mov ecx, success
    mov edx, success_len
    call printString

    mov ecx, withdrawn
    mov edx, withdrawn_len
    call printString
    mov eax, [amount]
    call printNum

    mov ecx, remaining
    mov edx, remaining_len
    call printString
    mov eax, [balance]
    call printNum
    ret

notEnough:
    mov ecx, insuff
    mov edx, insuff_len
    call printString
    ret

badAmount:
    mov ecx, inv_amount
    mov edx, inv_amount_len
    call printString
    ret

notMultiple:
    mov ecx, multiple
    mov edx, multiple_len
    call printString
    ret

textToNum:
    mov ecx, 0
    mov eax, 0
    jmp textToNumConvert

textToNumConvert:
    cmp ecx, [with_amount]
    jge ttnc_check
    mov dl, [w + ecx]
    cmp dl, 10
    je ttnc_check
    cmp dl, '0'
    jl ttnc_error
    cmp dl, '9'
    jg ttnc_error
    sub dl, '0'
    movzx edx, dl
    imul eax, eax, 10
    add eax, edx
    inc ecx
    jmp textToNumConvert

ttnc_check:
    cmp ecx, 0
    je ttnc_error
    ret

ttnc_error:
    mov eax, -1
    ret

printNum:
    mov esi, numbuf + 11
    mov byte [esi], 10
    dec esi

    cmp eax, 0
    jne convert
    mov byte [esi], '0'
    dec esi
    jmp display

convert:
    mov ebx, 10

getDigits:
    xor edx, edx
    div ebx
    add dl, '0'
    mov [esi], dl
    dec esi
    cmp eax, 0
    jne getDigits

display:
    inc esi
    mov edx, numbuf + 12
    sub edx, esi
    mov ecx, esi
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