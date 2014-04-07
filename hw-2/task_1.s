 .data

myint:.space 4
read_chislo:
	.string "%d "
	.text
wright_otvet1:
	.string "Kolichestvo edenits %d"
	.text
wright_otvet2:


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
		movl $myint,%eax
		movl $32, %ecx
		xorl %edx, %edx 
count:
		shll %eax 
		jnc no_carry
			inc %edx
		no_carry:
		loop count
//print 1resalt
		pushl %edx
		pushl $wright_otvet1
		call printf
		addl $8,%esp

//epilog
		movl	%ebp, %esp
		popl	%ebp
		movl $0,%eax
ret
		
