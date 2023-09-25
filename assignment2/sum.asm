; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

section .data
section .bss

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
    push qword 0
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
    global sum

sum:
    backup

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Array Size
    xor r13, r13  ; Loop Counter

    mov rax, 1
    mov rdx, 0
    cvtsi2sd xmm15, rdx ; xmm15 will hold our running sum

    loop:

        ; Check capacity
        cmp r13, r15
        je done

        ; Add current element
        addsd xmm15, [r14 + r13 * 8]

        inc r13 ; Counter increments
        jmp loop ; Loop repeats

    done:
        pop rax
        movsd xmm0, xmm15

        restore
        ret
