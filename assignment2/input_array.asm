; Name: Joel Daniel Rico
; CWID: 885687517
; Program: Prompts input and stores in array

global input_array
extern scanf, printf

segment .data
    float_format db "%lf", 0

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

%macro input 0
    mov rax, 0
    mov rdi, float_format
    push qword 0
    mov rsi, rsp
    call scanf 
%endmacro

segment .text
input_array:
    backup
    push qword 0

    ; Parameters
    mov r14, rdi  ; Array Pointer
    mov r15, rsi  ; Maximnum Array Size
    xor r13, r13  ; Loop Counter

loop:

    ; Check capacity
    cmp r13, r15
    je done

    ; User input
    input

    ; ???
    cdqe

    ; Ctrl+D check
    cmp rax, -1
    pop r12 ; Pop the value into r12
    je done

    ; Insert into array
    mov [r14 + r13 * 8], r12 
    inc r13 ; Counter increments
    jmp loop ; Loop repeats
done:

    ; Return final array size
    pop rax
    mov rax, r13

    restore
    ret
