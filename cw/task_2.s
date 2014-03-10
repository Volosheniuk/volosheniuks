.data
	int_label1:
	.int	3
	int_label2:
	.int	2
	int_label3:
	.int   1


	format_string:
	.string	"Hello world %d%d%d\n"
.text
	.globl	main
main:
	pushl		%ebp
	movl		%esp, %ebp

	pushl		int_label3
	pushl   	int_label2
	pushl   	int_label1

	pushl		$format_string
	call		printf
	addl		$8, %esp

	movl		%ebp, %esp
	popl		%ebp
	ret
