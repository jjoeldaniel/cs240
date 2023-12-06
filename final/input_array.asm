; Name: Joel Daniel Rico
; CWID: 885687517
; Email: joeldanielrico@csu.fullerton.edu
; Date: 12/06/23

global input_array
extern printf
extern rdrand

segment .data
    message1 db "The array has been filled with random numbers.", 10

%macro print 1
    push qword 0
    mov rax, 0
    mov rdi, %1
    call printf
    pop rax
%endmacro

segment .bss
    align 64
    storedata resb 832

segment .text
input_array:
    ; Back up components
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    xor         r13, r13                        ; r13 keeps track of the index of the loop 
    mov         r14, rdi                        ; rdi contains the address of the random_number_array   
    mov         r15, rsi                        ; rsi contains the count of the random_number_array

    print message1

fill_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         fill_finished

    ; Generate a random number and put it in r12
    rdrand      r12

    ; Move the random number into the array
    mov         [r14 + r13 * 8], r12

    ; Inrease the index and repeat the loop
    inc         r13      
    jmp         fill_loop

fill_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;Restore the original values to the GPRs
    popf          
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ; Clean up
    ret
