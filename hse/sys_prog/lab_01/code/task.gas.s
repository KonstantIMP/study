# Practice work number 1 
# by Dunikov Konstantin BIB224
# AT&T GAS implementation

# Task Number 3
# An array of 10 words is given
# Find the sum of the remainders from dividing each of them by 3
# Place the result in a separate data item.


# Compile-time initialized read-only variables
.section .rodata

# Some syscalls definitions
sys_read: .quad 0 
sys_write: .quad 1
sys_exit: .quad 60

# Default streams
stdin: .quad 0
stdout: .quad 1
stderr: .quad 2

# ASCI helpers
asci_0: .byte 48
message: .asciz "Your number is " # 14 characters + '\0'

# Array from condition
data: .word 0x0000, 0x1357, 0x2468, 0x1234, 0x5678, 0x0987, 0x6543, 0x1111, 0x2222, 0x3333


# Compile-time initialized read-write variables
.section .data

# Max value of mod 3 op is 2, for 10 values max sum is 20 - byte is enogh
result: .byte 0
temp_char: .byte 0

# Runtime initialized variable
.section .bss


# Actually code
.section .text

# Export symbol to linker
.globl _entrypoint

_entrypoint:

  setup:
    movq $data, %rsi  
    movq $0, %rcx

  calc_loop:
    cmpq $10, %rcx
    jge print_result

    movw $0, %dx
    movw (%rsi), %ax

    movw $3, %bx
    divw %bx

    addb %dl, result

    addq $2, %rsi

    incq %rcx
    jmp calc_loop

  print_result:
    movq sys_write, %rax
    movq stdout, %rdi
    movq $message, %rsi
    movq $16, %rdx
    syscall

    movw $0, %ax
    movb result, %al
 
    movw $0, %bx 
    movb $10, %bl
    divb %bl

    movw %ax, %bx
 
    movq sys_write, %rax
    movq stdout, %rdi
    movq $temp_char, %rsi
    movq $1, %rdx

    movb $48, temp_char
    addb %bl, temp_char
    syscall

    movb $48, temp_char
    addb %bh, temp_char
    syscall
    
    movb $'\n', temp_char
    syscall

  finilize:
    movq sys_exit, %rax
    movq $0, %rdi
    syscall

