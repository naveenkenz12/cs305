.data
	.align 2#word align
	s1: .asciiz "\n" #print newline
	
.text

main:
	addi $s0, $0, 10#a=10, saved in s0
	addi $s1, $0, 75#b=75, saved in s1

	addi $sp, $sp, -12#save in stack
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	add $a0, $s0, $0#a0=10 to pass arguements
	add $a1, $s1, $0#a1=75 to pass arguements

	jal gcd#function call

	move $a0, $v0#save return value to a0

	li $v0, 1#print value
	syscall

	li $v0, 4
	la $a0, s1 #print endline
	syscall #print on the console

	addi $sp, $sp, 12#restore stack npointer

	li $v0, 10      # end program
    syscall


gcd:
	move $t0, $a0#move value of a0 to t0
	move $t1, $a1#move value of a1 to t1

	loop:
		beq $t0, $t1, exit#if both arguements are equal exit from loop
		bgt $t0, $t1, gt#if x>y goto gt label
		blt $t0, $t1, ls#if x<y goto ls label
		ls:
			sub $t1, $t1, $t0#y=y-x
			j loop#continue loop

		gt:
			sub $t0, $t0, $t1#x=x-y
			j loop#continue loop

		exit:
			add $v0, $0, $t0#save x in v0
			jr $ra#return
