 .data

int_N:
	.space 4
float_n: 
	.space 4
myscan:
	.string "%f %d"

myprintf:
	.string "%f\n"
	.text
	.globl main

main:
	pushl	%ebp
	movl	%esp, %ebp
	movl	%ebp, %esp
popl	%ebp
	pushl  $int_N
	pushl  $float_n
	pushl  $myscan 
	call scanf
	addl $12, %esp

	movl int_N, %ecx
	movl $1, %eax
sum: 
	addl int_N,%eax
	loop sum
//print
	pushl  %eax
	pushl	$myprintf
	call printf
	addl $8,%esp
 
	movl	%ebp, %esp
	popl	%ebp

	movl $0,%eax
	ret
