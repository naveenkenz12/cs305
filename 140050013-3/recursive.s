.data
	s1: .asciiz "Enter n : "
	s2: .asciiz "The value of F(n) is : "

	.align 2

.text

main:
	li $v0, 4
	la $a0, s1 #$ao store the string to be printed initially
	syscall #print on the console
	
	li $v0, 5 # take integer input from user
	syscall
	move $t0, $v0 # store integer in t0

	add $a0, $t0, $0
	jal F# call function to calculate factorial
	add $t1, $v0, $0# copy value of t0 to t1

	li $v0, 4
	la $a0, s2 #$ao store the string to be printed finally
	syscall #print on the console
	move $a0, $t1#print the value
	li $v0, 1
	syscall
	li $v0, 10      # end program
    syscall


F:
	addi $t0, $0, 100#$t0 contains 100
	blt $a0, $t0, recurse#call recurse if a0 is less than or equal to 100
	beq $a0, $t0, recurse

	addi $v0, $a0, -10#decrease n by 10, if n>100

	jr   $ra

	recurse:
		addi $sp, $sp, -8           # stack frame 
		sw   $s0, 0($sp)       # will use for argument n   
		sw   $ra, 4($sp)      #  return address

		move $s0, $a0        #  save argument
		addi $a0, $a0, 11

		jal  F
		move $a0, $v0
		jal F
		lw   $s0, 0($sp)       # restore registers from stack
		lw   $ra, 4($sp) 
		addi $sp, $sp, 8
		jr   $ra
