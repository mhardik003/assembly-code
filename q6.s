/*

Compute the sum of first N numbers and return the modulus of sum with
respect to K.

• Input: NK
• Output: Integral value of the modulus.

*/

.section .rodata
.INP_STR:
    .string "%Ld %Ld" # input string for scanf since we are taking two inputs

.OUT_STR:
    .string "%d\n"  # output string for printf

.section .text
.globl  main

main:
    subq    $56, %rsp    # allocate 56 bytes of space on the stack (since 56 was not giving any errors)
    leaq    .INP_STR(%rip), %rdi    # load the input string into rdi which is the first argument to scanf
    leaq    (%rsp), %rsi    # load the address of the first element of the stack into rsi which is the second argument to scanf
    leaq    8(%rsp), %rdx   # load the address of the second element of the stack into rdx which is the third argument to scanf

    call    __isoc99_scanf@PLT   # calls the scanf function

    movq    (%rsp), %rax    # stores N in rax
    movq    8(%rsp), %rbx   # stores K in rbx
    movq    $0, %r11        # stores the sum
    movq    $0, %r8         # iterable for the sum

    jmp     .compute_sum


.compute_sum:

    addq    %r8, %r11       # add the iterable to the sum
    addq    $1, %r8         # increment the iterable
    cmp     %r8, %rax       # compare the iterable with N
    jge     .compute_sum    # if iterable <= N then jump to compute_sum
    jmp     .compute_remainder  # else jump to compute_remainder

.compute_remainder:

    cqto                    # sign extend rax into rdx
    
    mov     %r11, %rax      # move the sum into rax
    idivq   %rbx            # divide the sum by K and store the remainder in rdx

    leaq    .OUT_STR(%rip), %rdi    # load the output string into rdi which is the first argument to printf
    movq    %rdx, %rsi              # load the remainder into rsi which is the second argument to printf
    call    printf@PLT              # calls the printf function

    xorq    %rax, %rax              # set rax to 0 which is the return value
    addq    $56, %rsp               # deallocate the stack         
    ret

