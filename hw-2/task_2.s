 .data 

mystring:
	.space 12
str_out1:
	.space 12
str_1:
	.string "ssssssssssss\n"
prpr:
	.string "%d"
scanstring:
	.string "%s\n"
	
printstring:
	.string "%s\n"
mylength:
	.string "DLINA=%d\n"
	.globl main

//poisk dliny
my_strlen:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	movl 8(%ebp), %edi 
	movl $0xffffffff, %ecx 
	xorl %eax, %eax 
	repne scasb
	notl %ecx
	decl %ecx
	movl %ecx, %eax
	popl %edi
	movl %ebp, %esp
	popl %ebp
ret 


main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//read tsepochka
	pushl $mystring
	pushl $scanstring
	call  scanf
	addl  $8,%esp
//find length
	pushl $mystring
	call my_strlen
	
	pushl %eax
	pushl $mylength
	call printf
	addl $8,%esp
//movs
	//istochnik
	 movl $mystring,%esi
	//priemnik
	movl  $str_out1, %edi
	//kolichestvo hodov v tsikle
	decl %eax
	movl %eax,%ecx
	rep movsb
//proverka movs
	pushl $str_out1
	pushl $printstring
	call printf
	addl $8,%esp
//cmps
	//istochnik
         movl $mystring,%esi
        //priemnik
        movl  $str_1, %edi
        //kolichestvo hodov v tsikle
        decl %eax
        movl %eax,%ecx
	letsdoit: cmpsb 
		je cool
			pushl $1
                        pushl $prpr
                        call printf
                        addl $8,%esp
			
		
		cool: 
			pushl $0
			pushl $prpr
			call printf
			addl $8,%esp

		cmp $0, %ecx
		jne letsdoit
			jmp end

	end: 


	
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
ret


	
