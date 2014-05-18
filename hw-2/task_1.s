 .data

myint:
	.long 0
read_chislo:
	.string "%d"
	.text
wright_otvet1:
	.string "Kolichestvo edenits %d\n"
	.text
wright_otvet2:
	.string "NOT chislo=%d\n"

	.globl main
main:
//prolog
		pushl	%ebp
		movl	%esp, %ebp

//read data
		pushl   $myint
		pushl	$read_chislo
		call scanf
		addl $8, %esp
// schitaem kolichestvo edenichnih bitov
		movl (myint),%eax
		movl $32, %ecx
		xorl %edx, %edx 
count:
		shll %eax 
		jnc no_carry
			incl %edx
		no_carry:
		loop count
//print 1resalt
		pushl %edx
		pushl $wright_otvet1
		call printf
		addl $8,%esp

//epilog

//part2  printf not a
		movl (myint) ,%eax
		not %eax
		pushl %eax
		pushl $wright_otvet2
		call printf
		addl $8,%esp
		

		movl $0,%eax
		movl	%ebp, %esp
		popl	%ebp
		
ret
		
