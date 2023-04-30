/*
Given a number N, output if it is prime or not.

• Input: N
• Output: ”Y ” if the input is a prime number, else ”N”.
*/

.section .rodata
.INP_STR:
    .string "%Ld"

.YES_MSG:
    .string "Y\n"

.NO_MSG:
    .string "N\n"

.section    .text 
.globl  main   

main:
    subq    $56, %rsp   # allocate 56 bytes to the stack (since 56 was not giving any errors)
    leaq    .INP_STR(%rip), %rdi    # load the address of the input string into rdi which is the first argument of scanf
    leaq    (%rsp), %rsi            # load the address of the stack into rsi which is the second argument of scanf

    call __isoc99_scanf@PLT     # calls the scanf function


    movq    (%rsp),%r8      # move the input into r8
    movq    $2, %rbx        # move 2 into rbx (the divisor)

    jmp .loop               # jump to the loop

.loop:

    cmp     %rbx, %r8       # compare the divisor and the input
    je      .prime          # if they are equal, then the number is prime (since it is only divisible by 1 and itself)
    cqto                    # sign extend rax into rdx
    movq    %r8, %rax       # move the input into rax
    idivq   %rbx            # divide the input by the divisor
    cmp     $0, %rdx        # compare the remainder with 0
    je      .not_prime      # if the remainder is 0, then the number is not prime
    addq    $1, %rbx        # add 1 to the divisor
    jmp     .loop           # jump back to the loop

.prime:
    leaq    .YES_MSG(%rip), %rdi    # load the address of the yes message into rdi which is the first argument of printf
    call    printf@PLT              # call the printf function
    
    xorq    %rax, %rax              # set rax to 0 since it is the return value
    addq    $56 ,%rsp               # deallocating the 56 bytes we allocated earlier
    ret

.not_prime:
    leaq    .NO_MSG(%rip), %rdi     # load the address of the no message into rdi which is the first argument of printf
    call    printf@PLT              # call the printf function

    xorq    %rax, %rax              # set rax to 0 since it is the return value
    addq    $56 ,%rsp               # deallocating the 56 bytes we allocated earlier
    ret 
    