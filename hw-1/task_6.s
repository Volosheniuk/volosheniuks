	.data
mystring:
	.string "%lf"	
printmy:
	.string "%d"
double:
	.space 8
out:
	.string "\n"
	.text
	.globl main
main:
	pushl	%ebp	
	movl	%esp,	%ebp

	pushl	$double
	pushl	$mystring
	call	scanf
	addl	$8,	%esp

	
	pushl %ebx
	movl $4, %eax
	addl $double,%eax
	movl (%eax), %ebx
	movl %ebx, %eax
	popl %ebx
	movl	$64,	%ecx
move:
	cmpl $32,	%ecx
	jne	next
	movl $double, %eax
	pushl	%ebx
	movl	(%eax), %ebx
	movl	%ebx,	%eax
	popl	%ebx
next:
	shll	$1,	%eax
	movl	$0,	%ebx
	jnc	print	
	movl	$1,	%ebx
print:
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	
	pushl	%ebx	
	pushl	$printmy
	call	printf
	addl	$8,	%esp
	
	popl	%eax	
	popl	%ecx
	popl	%edx
	
	loop	move
	
	pushl	$out
	call	printf
	addl	$4, %esp
	
	movl	%ebp,	%esp	
	popl	%ebp
	
	movl	$0,	%eax	
ret	
