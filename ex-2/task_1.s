//stroka bez probelov!!!//100500 ne vhode 
.data
 str_1: 
	.space 100 
 str_2:
	.space 100
length1:
	.space 4
length2:
	.space 4
rez:
	.space 4
myscan:
	.string "%s"
printfanswer:
	.string "%d\n"

.text
.globl main
main:
//prolog
        pushl %ebp
        movl %esp, %ebp 
//read data1
	pushl $str_1	
	pushl $myscan
	call scanf
	addl $8,%esp
//read data 2
	pushl $str_2
	pushl $myscan
	call scanf
	addl $8, %esp
//ne sovpadaiet otvet -1
	movl $-1, rez
//naidem dliny 1
	movl $str_1, %esi
	movl $0, %ecx

findlength: 
	lodsb
	cmp $0, %al
	je finish11
	addl $1, %ecx
	jmp findlength
finish11:
		movl %ecx, length1
//naidem dliny2
        movl $str_2, %esi
        movl $0, %ecx
findlength2: 
        lodsb
        cmp $0, %al
        je finish2
        addl $1, %ecx
        jmp findlength2
finish2:
        movl %ecx, length2

	movl length2, %ecx
	movl length1, %eax
//sravnim dlinu
	cmp %eax, %ecx 
	jl rightanswer  
	addl $1, %ecx 
//poisk vhogdenia
tsikl:	
	subl $1, %ecx 
	pushl %ecx
	movl $str_2, %esi
	movl $str_1, %edi
	addl %ecx, %esi
	movl length1, %ecx
//proverka vhod
yes:
	pushl %ecx 
	cmpsb
	popl %ecx
	jne oncemore
	loop yes
	popl %ecx
	movl %ecx, rez 
	pushl rez
oncemore:
	popl %ecx
	addl $1, %ecx 
	loop tsikl
movl %ecx,rez
//otvet
rightanswer:
	addl $1, rez 
	pushl rez
	pushl $printfanswer
	call printf 
	addl $8, %esp        
	movl %ebp, %esp 

//epilog
        popl %ebp
        movl $0, %eax
        ret
 
