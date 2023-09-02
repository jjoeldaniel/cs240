section .data

    initial_speed db "Please enter the speed for the initial segment of the trip (mph):", 10
    miles db "For how many miles will you maintain this average speed?", 10
    final_speed db "What will be your speed during the final segment of the trip (mph)?", 10

section .text
    global _start
_start:

    ; prompt for initial speed
    mov rax, 1
    mov rdi, 0
    mov rsi, initial_speed
    mov rdx, 66
    syscall

    ; TODO: read initial speed

    ; prompt for miles
    mov rax, 1
    mov rdi, 0
    mov rsi, miles
    mov rdx, 57
    syscall

    ; prompt for final speed
    mov rax, 1
    mov rdi, 0
    mov rsi, final_speed
    mov rdx, 68
    syscall

    mov rax, 60
    mov rdi, 0
    syscall