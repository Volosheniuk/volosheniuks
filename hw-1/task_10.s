.data

mychar:
	.space 1
myshort:
        .space 2
myint:
        .space 4
mydouble:
        .space 8

scansc:
	.string "%c %hd %d %lf"
myprintchar:
	.string "%c "
myprintshort:
        .string "%hd "
fmt_pr_i:
        .string "%d "
fmt_pr_d:
        .string "%lf\n"
	.text
	.globl main

main:
//prolog
	pushl %ebp
	movl %esp, %ebp
	
	pushl $mydouble
	pushl $myint
	pushl $myshort
	pushl $mychar
	pushl $scansc
	call scanf
//here is char
	movb mychar, %al
	pushl %eax
	pushl $myprintchar
	        call printf
//here is shourt
	movw myshort, %ax
	        pushl %eax
	         pushl $myprintshort
	        call printf
//here is our int
	movl myint, %eax
	        pushl %eax
         pushl $fmt_pr_i
	        call printf
//make double	
	fldl mydouble
	movl $fmt_pr_d, %eax
fstpl	4(%esp)
	movl %eax, (%esp)
	call printf
	
	
//make stack well	
	movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret		
