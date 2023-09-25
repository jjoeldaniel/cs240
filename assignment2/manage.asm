; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

extern scanf, printf
extern input_array
extern output_array

section .data
    message1 db "We will take care of all your array needs.", 10, 0
    message2 db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    message3 db 10, "Thank you. The numbers in the array are:", 10, 0

    string_format db "%s", 0
    int_format db "%d", 0
    float_format db "%lf", 0

    maximum_array_size equ 8

section .bss
    align 16
    array: resq maximum_array_size

%macro print 2
    push qword 0
    mov rax, 0
    mov rdi, %1
    mov rsi, %2
    call printf
    pop rax
%endmacro

%macro prompt 0
    print string_format, message1
    print string_format, message2
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

    ; Initial prompt
    prompt

    ; Call input_array
    mov rax, 0
    mov rdi, array
    mov rsi, maximum_array_size
    call input_array
    mov r13, rax
    pop rax

    ; NOTE: r13 = array size

    ; Call output_array
    print string_format, message3
    mov rdi, array
    mov rsi, r13
    call output_array

    ; Return
    pop rax
    ; movsd xmm0, xmm15

    restore
    ret
