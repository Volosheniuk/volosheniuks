 .data
int_label1: 
	.space 4
int_label2:
	.space 4
scannn_string:
	.string "%d %d"
	.text
printfff_string:
	.string "%d\n"
	.text
	.globl main
main:
	pushl %ebp
	movl %esp,%ebp
	
	pushl $int_label2
	pushl $int_label1
	pushl $scannn_string
	call  scanf
      
        addl  $12, %esp
	

	movl int_label2 ,%eax
	addl int_label1,  %eax
	

	pushl %eax
	pushl $printfff_string
	call printf
        

	addl $8, %esp
	

	movl int_label1,%eax
	sub  int_label2, %eax
	

	pushl %eax
        pushl $printfff_string
        call printf
        
        addl $8, %esp
	
	movl int_label1, %eax
	mull int_label2


        pushl %eax
        pushl $printfff_string
        call printf
	

        addl $8, %esp


	
	movl %esp,%ebp
	popl %ebp

	movl $0, %eax
	
	ret
 


        
