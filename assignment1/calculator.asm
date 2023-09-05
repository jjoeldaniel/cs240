section .data

    initial_speed db "Please enter the speed for the initial segment of the trip (mph): ", 0
    miles db "For how many miles will you maintain this average speed? ", 0
    final_speed db "What will be your speed during the final segment of the trip (mph)? ", 0

    average_speed db "Your average speed will be ", 0
    total_time db "Your total time will be ", 0

    newline db "", 10
    test_data db "1", 10
    digit db 0, 10

section .bss
    initial_speed_input resb 16
    miles_input resb 16
    final_speed_input resb 16

section .text
    global _start

%macro quit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

%macro scanf 1
    mov rax, 0
    mov rdi, 0
    mov rsi, 1
    mov rdx, %1
    syscall
%endmacro

%macro printf 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro newline 0
    printf newline, 1
%endmacro

calculate:

    ; prompt for initial speed
    printf initial_speed, 66
    scanf initial_speed_input

    ; prompt for miles
    printf miles, 57
    scanf miles_input

    ; prompt for final speed
    printf final_speed, 68
    scanf final_speed_input
    
    quit