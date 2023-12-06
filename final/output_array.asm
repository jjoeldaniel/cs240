; Name: Joel Daniel Rico
; CWID: 885687517
; Email: joeldanielrico@csu.fullerton.edu
; Date: 12/06/23

extern printf

section .data
    float_format db "%f", 10, 0

section .text
    global output_array

%macro backup 0
    push rbp
    mov rbp,rsp
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

output_array:

    backup

    ; Params
    mov r15, rsi ; Array max size
    mov r14, rdi ; Array Pointer
    xor r13, r13 ; Counter

loop3:

    ; Check break condition
    cmp r13, r15
    je done

    ; Print current index
    push qword 0
    mov rax, 1
    movq xmm0, [r14 + r13 * 8]
    mov rdi, float_format
    call printf
    pop rax

    ; Increment the loop and restart
    inc r13
    jmp loop3

done:
    mov rax, 0
    pop rax

    restore
    ret

