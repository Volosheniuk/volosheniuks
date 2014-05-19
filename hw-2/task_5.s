 
 .text
 .globl sum1

 sum1:
	 pushl %ebp
	 movl %esp, %ebp
	 xorl %eax, %eax

	 movl 8(%ebp), %ebx
	 movl 12(%ebp), %ecx
 isumm:
	 movl (%ebx), %edx
	 addl %edx, %eax
 	addl $4, %ebx
 loop isumm


 movl %ebp, %esp
 popl %ebp
 ret

 .text

 .globl sum2

 sum2:
 	pushl %ebp
 	movl %esp, %ebp

 	subl $8, %esp
 	xorl %eax, %eax
 	movl %eax, -4(%ebp)
 	movl 12(%ebp), %ecx
 	movl 8(%ebp), %ebx

 summ:
 	movl %ebx, %eax
 	flds (%eax)
 	flds -4(%ebp)
 	faddp %st, %st(1)
 	fstps -4(%ebp)
 	addl $4, %ebx
 loop summ

 	flds -4(%ebp)
 	movl -4(%ebp), %eax

 	movl %ebp, %esp
 	popl %ebp
 ret
