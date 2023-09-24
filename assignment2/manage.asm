; Name: Joel Daniel Rico
; CWID: x
; Program: Prompts input and stores in array

extern scanf, printf
extern input_array

section .data
    prompt1 db "Welcome to Array Management System", 10
    prompt2 db "This product is maintained by Your Name at joeldanielrico@csu.fullerton.edu", 10

    string_format db "%s", 0
    float_format db "%lf", 0

    maximum_array_size equ 8

section .bss
    array: resq maximum_array_size

%macro prompt 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, prompt1
    call printf

    mov rax, 0
    mov rdi, string_format
    mov rsi, prompt2
    call printf
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

section .text
    global manage

manage:
    backup

    prompt

    restore
    ret
