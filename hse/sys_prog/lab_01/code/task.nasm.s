section .rodata

sys_write dq 1
sys_exit dq 60

stdout dq 1

asci_0 db 48
message db "Your number is " 

data dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1


section .data
result db 0
temp_char db 0


section .text

global _entrypoint

_entrypoint:
 
  setup:
    mov rsi, data
    mov rcx, 0

  calc_loop:
    cmp rcx, 10
    jge print_result

    mov dx, 0
    mov ax, [rsi]

    mov bx, 3
    div bx

    add [result], dl

    add rsi, 2

    inc rcx
    jmp calc_loop 

  print_result:
    mov rax, [sys_write]
    mov rdi, [stdout]
    mov rsi, message
    mov rdx, 16
    syscall

    mov ax, 0
    mov al, [result]

    mov bx, 0
    mov bl, 10
    div bl

    mov bx, ax

    mov rax, [sys_write]
    mov rdi, [stdout]
    mov rsi, temp_char
    mov rdx, 1

    mov [temp_char], byte 48
    add [temp_char], bl
    syscall

    mov [temp_char], byte 48
    add [temp_char], bh
    syscall

    mov [temp_char], byte 10
    syscall

  finilize:
    mov rax, [sys_exit]
    mov rdi, 0
    syscall  


