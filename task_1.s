 .data
msg_string_1:
.string "call 1.\n"
.text
.globl  main
msg_string_2:
.string "call 2.\n"
.text
.globl  main
main:
pushl   %ebp
bl  main
msg_f
movl    %esp, %ebp
    
pushl   $msg_string_1
call    printf
addl    $4, %esp

movl    %ebp, %esp
popl    %ebp
pushl   %ebp
movl    %esp, %ebp

pushl   $msg_string_2
call    printf
addl    $4, %esp

movl    %ebp, %esp
popl    %ebp

ret
