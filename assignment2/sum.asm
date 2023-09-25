; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

section .data
section .bss

%macro backup 0
    push rbp
    mov  rbp,rsp
    push rdi                                                    ;Backup rdi
    push rsi                                                    ;Backup rsi
    push rdx                                                    ;Backup rdx
    push rcx                                                    ;Backup rcx
    push r8                                                     ;Backup r8
    push r9                                                     ;Backup r9
    push r10                                                    ;Backup r10
    push r11                                                    ;Backup r11
    push r12                                                    ;Backup r12
    push r13                                                    ;Backup r13
    push r14                                                    ;Backup r14
    push r15                                                    ;Backup r15
    push rbx                                                    ;Backup rbx
    pushf 
    push qword 0
%endmacro

%macro restore 0
    popf                                                        ;Restore rflags
    pop rbx                                                     ;Restore rbx
    pop r15                                                     ;Restore r15
    pop r14                                                     ;Restore r14
    pop r13                                                     ;Restore r13
    pop r12                                                     ;Restore r12
    pop r11                                                     ;Restore r11
    pop r10                                                     ;Restore r10
    pop r9                                                      ;Restore r9
    pop r8                                                      ;Restore r8
    pop rcx                                                     ;Restore rcx
    pop rdx                                                     ;Restore rdx
    pop rsi                                                     ;Restore rsi
    pop rdi                                                     ;Restore rdi
    pop rbp                                                     ;Restore rbp
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
    cvtsi2sd xmm15, rdx ; total sum

    loop:

        ; Check capacity
        cmp r13, r15
        jge done

        ; Add current element
        addsd xmm15, [r14 + 8*r13]

        inc r13 ; Counter increments
        jmp loop ; Loop repeats

    done:
        pop rax
        movsd xmm0, xmm15

        restore
        ret
