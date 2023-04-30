/*
Compute the sum of first N numbers and return the modulus of sum with
respect to K.

• Input: NK
• Output: Integral value of the modulus.

*/
.section .rodata

.INP_STR:
    .string "%d %d %d %d"   # since we are taking 4 inputs

.OUT_STR:
    .string "%d\n"        # since we are printing 1 output

.section    .text

.globl main

main:
    subq    $72, %rsp
    leaq    .INP_STR(%rip), %rdi
    leaq    (%rsp), %rsi        # address of a11
    leaq    8(%rsp), %rdx       # address of a12
    leaq    16(%rsp), %rcx      # address of a21
    leaq    24(%rsp), %r8       # address of a22

    call    __isoc99_scanf@PLT   # calls the scanf function

    leaq    .INP_STR(%rip), %rdi    
    leaq    32(%rsp), %rsi      # address of b11
    leaq    40(%rsp), %rdx      # address of b12
    leaq    48(%rsp), %rcx      # address of b21
    leaq    56(%rsp), %r8       # address of b22

    call    __isoc99_scanf@PLT   # calls the scanf function

    jmp     .calculate

.calculate:

    xorq %rax, %rax     

    movq (%rsp), %r8        # a11                
    movq 32(%rsp), %r9      # b11
    imulq %r8, %r9          # a11 * b11
    addq %r9, %rax          # a11 * b11


    movq 8(%rsp), %r8       # a12
    movq 48(%rsp), %r9      # b21
    imulq %r8, %r9          # a12 * b21
    addq %r9, %rax          # a12 * b21


    movq (%rsp), %r8        # a11
    movq 40(%rsp), %r9      # b12
    imulq %r8, %r9          # a11 * b12
    addq %r9, %rax          # a11 * b12


    movq 8(%rsp), %r8       # a12
    movq 56(%rsp), %r9      # b22 
    imulq %r8, %r9          # a12 * b22
    addq %r9, %rax          # a12 * b22


    movq 16(%rsp), %r8      # a21
    movq 32(%rsp), %r9      # b11
    imulq %r8, %r9          # a21 * b11   
    addq %r9, %rax          # a21 * b11


    movq 24(%rsp), %r8      # a22
    movq 48(%rsp), %r9      # b21
    imulq %r8, %r9          # a22 * b21
    addq %r9, %rax          # a22 * b21


    movq 16(%rsp), %r8      # a21
    movq 40(%rsp), %r9      # b12
    imulq %r8, %r9          # a21 * b12
    addq %r9, %rax          # a21 * b12


    movq 24(%rsp), %r8      # a22
    movq 56(%rsp), %r9      # b22 
    imulq %r8, %r9          # a22 * b22
    addq %r9, %rax          # a22 * b22


    leaq .OUT_STR(%rip), %rdi   # address of output string being passed to rdi which is the first argument of printf
    movq %rax, %rsi             # value of sum being passed to rsi which is the second argument of printf
    call printf@PLT             # calls the printf function

    

    xorq %rax, %rax     # clearing the rax register to 0 since it is the return value 
    addq $72, %rsp      # clearing the stack
    ret


    


