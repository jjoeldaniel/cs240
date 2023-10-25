global rot_left

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

segment .text
    rot_left:
        
        ; Backup stuff
        backup

        ; Function parameters
        mov r14, rdi               ; array address
        mov r13, rsi               ; array length

        movsd xmm0, [r14]          ; first index

        ; Function body
        mov r15, 1                 ; loop counter starting at 1

    begin_loop:
        cmp r15, r13               ; check for counter == arr length
        je end_loop                ; if ==, end loop

        ; shift elements to right 
        movsd xmm1, [r14 + r15 * 8]        ; xmm1 = a[i]
        movsd [r14 + (r15 - 1) * 8], xmm1  ; a[i-1] = a[i]

        inc r15                    ; increment loop counter
        jmp begin_loop

    end_loop:
        movsd [r14 + (r13 - 1) * 8], xmm0
        restore
        ret
