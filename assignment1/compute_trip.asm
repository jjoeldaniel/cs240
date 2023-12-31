; Joel Daniel Rico
; CPSC 240
; Section 01
; Program Name: CPSC 240 Assignment 1 - Compute Trip

extern scanf, printf

section .data

    text_initial_speed db "Please enter the speed for the initial segment of the trip (mph): ", 0
    text_miles db "For how many miles will you maintain this average speed? ", 0
    text_final_speed db "What will be your speed during the final segment of the trip (mph)? ", 0

    string_format db "%s", 0
    float_format db "%lf", 0
    newline db "", 10

    text_average_speed db 10, "Your average speed will be %lf", 10
    text_total_time db "Your total time will be %lf hours", 10

    initial_speed dq 0.0
    miles dq 0.0
    final_speed dq 0.0

    distance dq 253.5

section .text
    global calculate

%macro print 1
    mov rax, 0
    mov rdi, string_format
    mov rsi, %1
    call printf
%endmacro

%macro input 1
    mov rax, 0
    mov rdi, float_format
    mov rsi, rsp
    call scanf
    movsd xmm%1, [rsp]
%endmacro

%macro takeInput 2
    print %1
    input %2
%endmacro

%macro backup 0
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
%endmacro

%macro restore 0
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
%endmacro

calculate:
    backup

    ; prompt for initial speed
    takeInput text_initial_speed, 0
    movsd qword [initial_speed], xmm0
    
    ; prompt for miles
    takeInput text_miles, 1
    movsd qword [miles], xmm1

    ; prompt for final speed
    takeInput text_final_speed, 2
    movsd qword [final_speed], xmm2

    ; load distance
    movsd xmm3, qword [distance]

    ; xmm0 = initial speed
    ; xmm1 = initial distance
    ; xmm2 = final speed
    ; xmm3 = total distance

    ; xmm4 = total time
    ; xmm5 = ( (distance - initial distance) / final speed )
    ; xmm6 = average speed

    ; ( initial distance / initial speed )
    movsd xmm4, [miles]
    divsd xmm4, [initial_speed]

    ; ( (total distance - initial distance) / final speed )
    movsd xmm5, [distance]
    subsd xmm5, [miles]
    divsd xmm5, [final_speed]

    ; total time = ( initial distance / initial speed ) + ( (total distance - initial distance) / final speed )
    addsd xmm4, xmm5

    ; average speed = total distance / total time
    movsd xmm6, [distance]
    divsd xmm6, xmm4

    ; print average speed
    movsd xmm0, xmm6
    mov rax, 1
    mov rdi, text_average_speed
    call printf

    ; print total time
    movsd xmm0, xmm4
    mov rax, 1
    mov rdi, text_total_time
    call printf

    restore
    ret