 .data

 int_l:
 	.space 4
scanstring:
	.string "%d"
	.text
less2:
	.string "<2\n"
	.text
less6:
	.string "2<=x<6\n"
	.text
less18:  
	.string "6<=x<18 %d\n"
	.text
b18:
	.string ">=18\n"
	.globl main
main:
//prolog
	pushl %ebp
	movl %esp,%ebp

//readdata
	
	pushl $int_l
	pushl $scanstring
	call scanf
	addl $8,%esp
	movl int_l, %eax
     //switch
     	cmp $2, %eax
	jb  case2
		cmp $6,%eax
		jb case6
			cmp $18,%eax
			jb case18

			jmp case19
	case2:
		pushl %eax
		pushl $less2
		jmp flag
	case6:
		pushl %eax
		pushl $less6
		jmp flag
	case18:
		pushl %eax
		pushl $less18
		jmp flag
	case19:
		pushl %eax
		pushl $b18
		jmp flag
	

	flag: 
		call printf
		addl $8, %esp

	//epilog
		 movl %esp,%ebp
		 popl %ebp
		 movl $0,%eax

		 ret
