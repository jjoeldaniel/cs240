; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

extern printf

section .data
    string_format db "%s", 0
    float_format db "%lf", 0
    msg db "yo", 10, 0

section .bss

%macro print 2
    push qword 0
    mov rax, 0
    mov rdi, %1
    mov rsi, %2
    call printf
    pop rax
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
    global output_array

output_array:
    backup

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Array Size
    xor r13, r13  ; Loop Counter

    loop:

        ; Check capacity
        cmp r13, r15
        je done

        ; NOTE: Test msg for sanity checking
        print string_format, msg

        ; Get current element
        movsd xmm0, [r14 + r13 * 8]

        ; mov rdi, float_format
        ; movsd [rsi], xmm0
        ; call printf

        inc r13 ; Counter increments
        jmp loop ; Loop repeats

    done:
        restore
        ret
