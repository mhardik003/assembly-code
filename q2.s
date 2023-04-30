/*
Check if a given 64-bit number contains odd number of 1s in its bit representation.

• Input: N
• Output: ”Y ” if the input has odd number of 1s, else ”N”.

*/

.section    .rodata

.INP_STR:
    .string "%Ld"    # input string

.YES_MSG:
    .string "Y\n"   # output string if the number of 1s is odd

.NO_MSG:
    .string "N\n"   # output string if the number of 1s is even


.section    .text
.globl      main

main:

    subq    $56, %rsp                # allocate space for 56 bytes on the stack
    leaq    .INP_STR(%rip), %rdi    # load the address of the input string into rdi which is the first argument to scanf
    leaq    (%rsp), %rsi            # load the stack pointer into rsi which is the second argument to scanf
    call    __isoc99_scanf@PLT      # call scanf

    
    movq    (%rsp), %rax            # now rax will have the input value
    
    movq    $2, %r8                 # r8 will have the divisor 2 (since we are checking for odd number of 1s)
    xor     %rsi, %rsi              # clear rsi to 0

    jmp     .loop_checker           # jump to the loop checker

.loop:  
    cqto                    # sign extend rax into rdx
    idivq   %r8             # divide rax by r8(2) and store the quotient in rax and the remainder in rdx
    addq    %rdx, %rsi      # add the remainder to rsi
    
    jmp     .loop_checker   # jump to the loop checker

.loop_checker:

    cmpq    $0, %rax    # compare rax with 0 (if the quotient is 0 then the loop should end)
    jg      .loop       # if rax is greater than 0 then jump back to the loop
    jmp     .checker    # else jump to the checker

.checker:

    movq    %rsi, %rax  # move the value of rsi to rax
    cqto                # sign extend rax into rdx
    idivq   %r8         # divide rax by r8(2) and store the quotient in rax and the remainder in rdx
    cmpq    $0, %rdx    # compare rdx with 0 (if the remainder is 0 then the number of 1s is even)

    jne     .was_odd    # if the remainder is not 0 then jump to .was_odd
    je      .was_notodd # else jump to .was_notodd

.was_odd:

    leaq    .YES_MSG(%rip), %rdi
    jmp     .end
 

.was_notodd:

    leaq    .NO_MSG(%rip), %rdi
    jmp     .end


.end:
    call    printf@PLT
    xorl    %eax, %eax
    addq    $56, %rsp
    ret


