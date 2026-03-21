section .data
    msg db "####### ASM Template Ready #######", 10
    len equ $ - msg

section .text
    global _start

_start:
    mov rsi, msg      ; std_out buffer
    mov rdx, len      ; std_out length
    call std_out

    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status = 0
    syscall
    
; RSI std_out buffer
; RDX std_out length
std_out:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; fd: stdout

    syscall
    ret