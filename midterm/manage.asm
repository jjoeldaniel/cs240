; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

extern scanf, printf
extern input_array
extern output_array
extern sum
extern rot_left

section .data
    message1 db "Please enter floating point numbers separated by ws. After the last valid input enter one more ws followed by control+d", 10, 10, 0
    this_arr db 10, "This is the array: ", 0
    here_arr db 10, "Here is the array: ", 0
    rot1 db 10, 10, "Function rot-left was called 1 time.", 10, 0
    rot2 db 10, 10, "Function rot-left was called 2 times consecutively.", 10, 0
    rot3 db 10, 10, "Function rot-left was called 3 times consecutively.", 10, 0

    float_format db "%lf", 0

    maximum_array_size equ 8

section .bss
    align 64
    Save resb 832

    array resq maximum_array_size

%macro print 1
    push qword 0
    mov rax, 0
    mov rdi, %1
    call printf
    pop rax
%endmacro

%macro print_here_array 0
    print here_arr
    ; Call output_array
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call output_array
    pop rax
%endmacro

%macro print_this_array 0
    print this_arr
    ; Call output_array
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call output_array
    pop rax
%endmacro

%macro sum 0
    ; Calculate Sum
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call sum
    movsd xmm15, xmm0
    pop rax
%endmacro

%macro rotate 0
    ; Call rot_left
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left
    pop rax
%endmacro

%macro backup 0
        ; backup registers
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
        pushf

        ; xsave
        mov rax, 7
        mov rdx, 0
        xsave [Save]
%endmacro

%macro restore 0
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        popf
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

section .text
    global manage

manage:
    backup

    ; Initial prompt
    print message1

    ; Call input_array
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, maximum_array_size
    call input_array
    mov r13, rax
    pop rax

    ; NOTE: r13 = Size of array

    ; Print inputted array
    print_this_array
    
    ; Rotate once and print array
    rotate
    print rot1
    print_here_array

    ; Rotate three times and print array
    print rot3
    rotate
    rotate
    rotate
    print_here_array
 
    ; Rotate two times and print array
    print rot2
    rotate
    print_here_array

    ; Calculate sum
    sum

    ; Return
    movsd xmm0, xmm15
    pop rax

    restore
    ret
