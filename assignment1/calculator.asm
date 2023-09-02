section .data

    initial_speed db "Please enter the speed for the initial segment of the trip (mph): ", 0
    miles db "For how many miles will you maintain this average speed? ", 0
    final_speed db "What will be your speed during the final segment of the trip (mph)? ", 0

    average_speed db "Your average speed will be ", 0
    total_time db "Your total time will be ", 0

    newline db "", 10
    test_data db "1", 10

section .bss

    initial_speed_res resb 16
    miles_res resb 16
    final_speed_res resb 16
    average_speed_res resb 16
    total_time_res resb 16

    first_travel_time resb 16
    second_travel_time resb 16

section .text
    global _start
_start:

    call _promptSpeed
    call _getSpeed

    call _promptMiles
    call _getMiles

    call _promptFinalSpeed
    call _getFinalSpeed

    ; TODO: calculate average
    call _printAverage


    call _quit

_quit:
    mov rax, 60
    mov rdi, 0
    syscall

_newline:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret

_printAverage:
    call _newline

    mov rax, 1
    mov rdi, 1
    mov rsi, average_speed
    mov rdx, 27
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, test_data
    mov rdx, 2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, total_time
    mov rdx, 24
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, test_data
    mov rdx, 2
    syscall

    ret

_promptSpeed:
    mov rax, 1
    mov rdi, 1
    mov rsi, initial_speed
    mov rdx, 67
    syscall
    ret

_getSpeed:
    mov rax, 0
    mov rdi, 0
    mov rsi, initial_speed_res
    mov rdx, 16
    syscall
    ret

_promptMiles:
    mov rax, 1
    mov rdi, 1
    mov rsi, miles
    mov rdx, 58
    syscall
    ret

_getMiles:
    mov rax, 0
    mov rdi, 0
    mov rsi, miles_res
    mov rdx, 16
    syscall
    ret

_promptFinalSpeed:
    mov rax, 1
    mov rdi, 0
    mov rsi, final_speed
    mov rdx, 69
    syscall
    ret

_getFinalSpeed:
    mov rax, 0
    mov rdi, 0
    mov rsi, final_speed_res
    mov rdx, 16
    syscall
    ret