.data
   .align 2#word align 
   buffer: .space 30
   s1: .asciiz "Please enter your name :"
   s2: .asciiz "Hello "

.text
   
main:
    la $a0, s1    # Load and print string asking for string
    li $v0, 4
    syscall

    li $v0, 8       # take in input

    la $a0, buffer  # load byte space into address
    li $a1, 30      # allot the byte space for string

    move $t0, $a0   # save string to t0
    syscall

    la $a0, s2    # load and print Hello name string
    li $v0, 4
    syscall

    la $a0, buffer  # reload byte space to primary address
    move $a0, $t0  
    li $v0, 4       # print string
    syscall

    li $v0, 10      # exit program
    syscall
