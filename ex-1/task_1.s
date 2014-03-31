	.data
myprint:
 .string "%u\n"
data:
	.space 1024
string:
	.string "%s"
	.text
.global length
.globl main

main:
	pushl %ebp
	movl %esp, %ebp
	pushl $data
	call length
	pushl %eax
	pushl $myprint
	call printf

	movl $0, %eax

	movl %ebp, %esp
	popl %ebp
ret
length:
        pushl %ebp
        movl %esp, %ebp
        pushl $data
        pushl $string
        call scanf
        addl $8, %esp
        pushl %edi
        movl 8(%ebp), %edi
        movl $0xffffffff, %ecx
        xorl %eax, %eax
        repne scasb
        notl %ecx
        decl %ecx
        movl %ecx, %eax
        popl %edi
        movl %ebp, %esp
        popl %ebp
ret

