; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

section .data

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
        mov rax , 7
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

segment .bss
    align 64
    Save resb 832

section .text
    global sum

sum:
    backup

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Array Size
    xor r13, r13  ; Loop Counter

    xorpd xmm0, xmm0

    loop:

        ; Check capacity
        cmp r13, r15
        jge done

        ; Add current element
        movsd xmm1, qword [r14 + r13 * 8]
        addsd xmm0, xmm1

        inc r13 ; Counter increments
        jmp loop ; Loop repeats

    done:
        movsd qword [r12], xmm0
        movq r12, xmm0

        restore
        ret
