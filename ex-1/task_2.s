 .data
int_a:
	.space 4
int_b:
	.space 4
scanstring:
	.string "%d %d"
	.text
cheker1:
	.string "perepolnenie\n"
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
			jmp pr
		bolshe: 
		    movl %eax,%edx
		    subl $1073741824, %edx
		    addl %ebx,%edx
		    subl  $1073741824, %edx
		    movl %edx,%eax
		    dec %eax
		    jmp  pr
	
letsdo:	
	addl %ebx,%eax
	jmp pr
pr:
	pushl %eax
	pushl $printstring
	call printf
end:
	movl	%ebp, %esp
	popl	%ebp
	movl $0, %eax
	ret
