   .data
mystring:
    .string "%Le"
int_print:
    .string "%d"
long_double:
    .space 10
out:
    .string "\n"
    .text
    .globl main
main:
    pushl %ebp
    movl %esp, %ebp

    pushl $long_double
    pushl $mystring
    call scanf
    addl $8, %esp


    pushl %ebx
    movl $6, %eax
    addl $long_double,%eax
    movl (%eax), %ebx
    movl %ebx, %eax
    popl %ebx
    movl $80, %ecx

move:
    cmpl $48, %ecx
    jne next
    movl $2, %eax
    addl $long_double, %eax
    movl (%eax), %ebx
    movl %ebx, %eax
    popl %ebx
next:
    cmpl $16, %ecx
    jne next_next
    movl $long_double, %eax
    pushl %ebx
    movl (%eax), %ebx
    movl %ebx, %eax
    popl %ebx
next_next:
    shll $1, %eax
    movl $0, %ebx
    jnc print
    movl $1, %ebx
print:
    pushl %edx
    pushl %ecx
    pushl %eax
    
    pushl %ebx
    pushl $int_print
    call printf
    addl $8, %esp

    popl %eax
    popl %ecx
    popl %edx

    loop move

    pushl $out
    call printf
    addl $4, %esp

    movl %ebp, %esp
    popl %ebp

    movl $0, %eax
ret
