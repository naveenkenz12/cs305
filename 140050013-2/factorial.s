.data
	.align 2#word align
	s1: .asciiz "Give a number : " #print for taking input
	s2: .asciiz "Factorial is " #print the factorial

.text

main:
	li $v0, 4
	la $a0, s1 #$ao store the string to be printed initially
	syscall #print on the console
	
	li $v0, 5 # take integer input from user
	syscall
	move $t0, $v0 # store integer in t0

	add $a0, $t0, $0
	jal FACTORIAL# call function to calculate factorial
	add $t1, $v0, $0# copy value of t0 to t1

	li $v0, 4
	la $a0, s2 #$ao store the string to be printed finally
	syscall #print on the console
	move $a0, $t1#print the value
	li $v0, 1
	syscall
	li $v0, 10      # end program
    syscall


FACTORIAL:
	addi $t5, $0, 1#initialize t5 to 1
	add $t6, $a0, $0#t6 contain the integer of ehich factorial is to be calculated
	addi $t7, $0, 1#value of factorial initialized to 1

	loop:
		bgt $t5, $t6, exit#if t5>t6 then exit
		mul $t7, $t7, $t5#multiply factorial by next number
		addi $t5, $t5, 1#increament t5 by 1
		j loop#return to loop again

	exit:
		add $v0, $t7, $0#v0=t7

	jr $ra# return