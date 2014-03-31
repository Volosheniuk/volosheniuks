 .data
int_a:
	.space 4
int_b:
	.space 4
scanstring:
	.string "%d %d"
	.text
cheker1:
	.string "%d +2^32\n"
printstring:
	.string "%d\n"
	.text
	.globl main
main:
//prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl  $int_b
	pushl  $int_a
	pushl  $scanstring
	call scanf
	addl  $12, %esp
	
	movl  int_a, %eax
	movl  int_b,%ebx
	movl  int_a,%ecx
	addl  int_b,%ecx


	cmp $0,%ecx
	jg  letsdo
	   //yhy
		cmp %ebx,%eax
		jg bolshe
			movl  %ebx,%edx
			subl  $1073741824, %edx
			addl %eax,%edx
			subl $1073741824, %edx
                    	movl %edx,%eax
			dec %eax
			jmp pr1
		bolshe: 
		    movl %eax,%edx
		    subl $1073741824, %edx
		    addl %ebx,%edx
		    subl  $1073741824, %edx
		    movl %edx,%eax
		    dec %eax
		    jmp  pr1
	
letsdo:	
	addl %ebx,%eax
	jmp pr
pr:
	pushl %eax
	pushl $printstring
	call printf
	addl $8,%esp
	jmp end
pr1:	
	pushl %eax
	pushl $cheker1
	call printf
	addl $8,%esp
	jmp end
	
end:
	movl	%ebp, %esp
	popl	%ebp
	movl $0, %eax
	ret
