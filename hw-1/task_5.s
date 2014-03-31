	.data
mysting:
	.string "%f"
myprint:
	.string "%d"
float:
	.space 4
myletsprint:
	.string "\n"
	.text
	.globl main
main:
//prolog
	pushl	%ebp	
	movl	%esp,	%ebp
//read data
	pushl	$float	
	pushl	$mysting
	call	scanf
	addl	$8,	%esp

	movl	float,	%eax	
	movl	$32,	%ecx
	movl	$0,	%edx
//main part 
move:
	shll	$1,	%eax
	movl	$0,	%ebx
	jnc	print	
	movl	$1,	%ebx
	movl	$1,	%edx
	print:
	cmpl	$1,	%edx
	jne	end
	
	pushl	%edx	
	pushl	%ecx
	pushl	%eax
	
	pushl	%ebx	
	pushl	$myprint
	call	printf
	addl	$8,	%esp
	
	popl	%eax	
	popl	%ecx
	popl	%edx
	end:
	loop	move

	pushl	$myletsprint
	call	printf
	addl	$4, %esp
	
	movl	%ebp,	%esp	
	popl	%ebp

	movl	$0,	%eax	
ret
