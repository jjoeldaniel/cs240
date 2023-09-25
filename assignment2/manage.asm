; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

extern scanf, printf
extern input_array
extern output_array
extern sum
extern exit

section .data
    message1 db "We will take care of all your array needs.", 10, 0
    message2 db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    message3 db 10, "Thank you. The numbers in the array are:", 10, 0
    message4 db "The sum of numbers in the array is %8.10lf", 10, 0
    message5 db 10, "Thank you for using Array Management System.", 10, 0

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
    push rbp                                          ;Backup rbp
    mov  rbp,rsp                                      ;The base pointer now points to top of stack
    push rdi                                          ;Backup rdi
    push rsi                                          ;Backup rsi
    push rdx                                          ;Backup rdx
    push rcx                                          ;Backup rcx
    push r8                                           ;Backup r8
    push r9                                           ;Backup r9
    push r10                                          ;Backup r10
    push r11                                          ;Backup r11
    push r12                                          ;Backup r12
    push r13                                          ;Backup r13
    push r14                                          ;Backup r14
    push r15                                          ;Backup r15
    push rbx                                          ;Backup rbx
    pushf
    push qword 0
%endmacro

%macro restore 0
    popf                                    ;Restore rflags
    pop rbx                                 ;Restore rbx
    pop r15                                 ;Restore r15
    pop r14                                 ;Restore r14
    pop r13                                 ;Restore r13
    pop r12                                 ;Restore r12
    pop r11                                 ;Restore r11
    pop r10                                 ;Restore r10
    pop r9                                  ;Restore r9
    pop r8                                  ;Restore r8
    pop rcx                                 ;Restore rcx
    pop rdx                                 ;Restore rdx
    pop rsi                                 ;Restore rsi
    pop rdi                                 ;Restore rdi
    pop rbp                                 ;Restore rbp
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

    ; Print Sum
    push qword 0
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, message4
    call printf
    pop rax

    ; Print final message
    print message5

    ; Return
    movsd xmm0, xmm15
    pop rax

    restore
    ret
