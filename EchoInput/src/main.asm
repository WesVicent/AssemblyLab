READ_BUFFER_SIZE equ 64

section .bss
    read_buffer resb READ_BUFFER_SIZE   ; Reserve 64 bytes for user input

section .data    
    MSG db "Say something: ", 10, "- "
    MSG_LEN equ $ - MSG

    ECHO_MSG db "Echo says: ", 10, "- "
    ECHO_MSG_LEN equ $ - ECHO_MSG

section .text
    global _start

_start:
    mov rsi, MSG
    mov rdx, MSG_LEN
    call std_out

    lea rsi, [read_buffer]      ; buffer address ; Load effective address of our buffer
    mov rdx, READ_BUFFER_SIZE   ; max number of bytes to read 
    call std_in

    mov rbx, rax                ; Byte read count save

    mov rsi, ECHO_MSG
    mov rdx, ECHO_MSG_LEN
    call std_out
    
    lea rsi, [read_buffer]      ; std_out buffer
    mov rdx, rbx                ; std_out length
    call std_out
    
    mov rax, 60                 ; syscall: exit
    xor rdi, rdi                ; status = 0
    syscall

; RSI std_in buffer
; RDX std_in length
std_in:
    mov rax, 0                  ; syscall: read
    mov rdi, 0                  ; fd: stdin

    syscall
    ret
    
; RSI std_out buffer
; RDX std_out length
std_out:
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; fd: stdout

    syscall
    ret