; Name: Joel Daniel Rico
; CWID: 885687517
; Email: joeldanielrico@csu.fullerton.edu
; Date: 12/06/23

global output_array
extern printf

segment .data
    output_format db "0x%016lx    %-18.13g", 10, 0

%macro backup 0
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
%endmacro

%macro restore 0
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
%endmacro

segment .bss
    align 64
    storedata resb 832

segment .text

output_array:
    backup

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    xor         r13, r13     ; r13 keeps track of the index of the loop    
    mov         r14, rdi     ; rdi contains the array
    mov         r15, rsi     ; rsi contains the count of the array

output_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         output_finished
    
    ; Print the number inside the array in hex and scientific format
    mov         rax, 1
    mov         rdi, output_format  
    mov         rsi, [r14 + r13  * 8]
    movsd       xmm0, [r14 + r13 * 8]
    call        printf   

    ; Inrease the index and repeat the loop
    inc         r13      
    jmp         output_loop

output_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;Restore the original values to the GPRs
    restore

    ; Clean up
    ret
