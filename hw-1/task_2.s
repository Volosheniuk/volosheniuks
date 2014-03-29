.data
int_label1:
	.space	4
scanfstring:
	.string	"%d"
endl:
	.string "\n"
	.text
	.globl main
main:
//prolog
	pushl	%ebp	
	movl	%esp, %ebp	
//read data
	pushl	$int_label1	
	pushl	$scanfstring	
	call	scanf
	addl	$8, %esp
	movl	int_label1,	%eax

	movl	$32,	%ecx

chainge:
	shll	$1,%eax

	movl	$0, %ebx
	jnc printb
	incl	%ebx

printb:
	pushl %eax
	pushl	%ecx
	pushl	%ebx
	pushl	$scanfstring	
	call printf
	addl	$8,	%esp
	popl	%ecx
	popl	%eax
	loop	chainge

        pushl $endl
        call printf
        addl $4, %esp


	movl	%ebp,	%esp
	popl	%ebp
	movl $0, %eax
ret
