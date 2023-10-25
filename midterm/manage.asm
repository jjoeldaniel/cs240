; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

extern scanf, printf
extern input_array
extern output_array
extern sum

section .data
    message1 db "We will take care of all your array needs.", 10, 0
    message2 db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    message3 db 10, "Thank you. The numbers in the array are:", 10, 0

    float_format db "%lf", 0

    maximum_array_size equ 8

section .bss
    align 16
    array resq maximum_array_size

%macro print 1
    push qword 0
    mov rax, 0
    mov rdi, %1
    call printf
    pop rax
%endmacro

%macro backup 0
    push rbp
    mov  rbp,rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf
    push qword 0
%endmacro

%macro restore 0
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp
%endmacro

section .text
    global manage

manage:
    backup

    ; Initial prompt
    print message1
    print message2

    ; Call input_array
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, maximum_array_size
    call input_array
    mov r13, rax
    pop rax

    ; NOTE: r13 = Size of array

    print message3

    ; Call output_array
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call output_array
    pop rax

    ; Calculate Sum
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call sum
    movsd xmm15, xmm0
    pop rax

    ; Return
    movsd xmm0, xmm15
    pop rax

    restore
    ret
