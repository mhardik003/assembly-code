/*
Given a number N ,check if the sum of the factorial of digits is equal to N
(special number).

• Input: N
• Output: ”Y ” if the input is a special number, else ”N”.
*/

.section .rodata

.INP_STR:
    .string "%Ld"    # stores the format string for scanf

.YES_MSG:
    .string "Y\n"   # stores the format string for printf

.NO_MSG:
    .string "N\n"   # stores the format string for printf


.section .text

.globl main

main:

    subq    $56, %rsp           # allocating space for the variables on the stack (56 since it was working without giving any errors)
    leaq    .INP_STR(%rip), %rdi    # stores the format string in %rdi which is the first argument to scanf
    leaq    (%rsp), %rsi            # stores the address of the variable in %rsi which is the second argument to scanf    
    call    __isoc99_scanf@PLT      # calls the scanf function

    movq    (%rsp), %rax    # stores the input in %rax
    movq    %rax , %r8      # stores the input copy again in %r8 to compare later
    movq    $0, %r9         # this will store the sum of the factorials of the digits
    movq    $10, %rbx       # to store the number 10
    
    jmp     .get_digits

.get_factorial:

    imulq   %r12, %r11  # calculating the factorial
    addq    $1, %r12    # incrementing the iterable
    jmp     .sum        # jump to the sum

.sum:

    cmp     %rdx, %r12      # checks if the iterable is equal to the digit
    jle     .get_factorial  # if not then get the next factorial
    
    addq    %r11, %r9       # add the factorial calculated (in %r11) to the sum being calculated (in %r9)
    jmp     .get_digits     # jump to get the next digit

.get_digits:

    cmp     $0, %rax    # checks if %rax has become zero or not
    je      .end        # if yes then get out of the loop
    
    cqto    
    idivq   %rbx        # divding by 10 to get the last digit in %rdx
    
    cmp     $0, %rdx    # checks if the digit is zero or not
    je      .digit_0    # if yes then jump to .digit_0
    
    mov     $1 , %r11   # stores the factorial
    mov     $1, %r12    # stores the iterable

    jmp     .sum

.digit_0:   # if the digit is zero then the factorial is 1
    
    addq    $1, %r9         # add 1 to the sum
    jmp     .get_digits     # jump to get the next digit

.end:

    cmp     %r9, %r8    # comparing the sum with the original number
    je      .yes        # if equal then jump to .yes
    jne     .no         # if not equal then jump to .no

.yes:  # code to print yes and exit the program

    leaq    .YES_MSG(%rip), %rdi    # stores the format string in %rdi which is the first argument to printf
    call    printf@PLT              # calls the printf function
    addq    $56, %rsp            # deallocating the space allocated on the stack
    xorq    %rax, %rax           # clearing the %rax register to 0 since it is the return value
    ret

.no:    # code to print no and exit the program
    leaq    .NO_MSG(%rip), %rdi    # stores the format string in %rdi which is the first argument to printf
    call    printf@PLT              # calls the printf function
    addq    $56, %rsp           # deallocating the space allocated on the stack
    xorq    %rax, %rax          # clearing the %rax register to 0 since it is the return value
    ret                         

