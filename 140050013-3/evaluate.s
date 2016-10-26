.data
	s1: .asciiz "Enter the pair x,y : "
	s2: .asciiz "Enter the coefficients a, b, c : "
	s3: .asciiz "The value of polynoimials at given point is : "

	.align 2

.text

main:
	li $v0, 4	#print s1, enter the pair x, y
	la $a0, s1
	syscall

	addi $sp, $sp, -20	# createing space for 5 integer input

	li $v0, 5	#take input pair x, y
	syscall

	sw $v0, 0($sp) #first 4 bytes of sp as x

	li $v0, 5	#take input pair x,y
	syscall

	sw $v0, 4($sp) #next 4 bytes of sp as y

	li $v0, 4	#print s2, enter the coefficients a, b, c
	la $a0, s2
	syscall

	li $v0, 5	#take input coefficients a
	syscall

	sw $v0, 8($sp) #next 4 bytes as a

	li $v0, 5	#take input coefficients b
	syscall

	sw $v0, 12($sp) #next 4 bytes of sp as b

	li $v0, 5	#take input coefficients c
	syscall

	sw $v0, 16($sp) #next 4 bytes of sp as c
	
	jal EVALUATE # call function

	move $t0, $v0	#print answer
	
	li $v0, 4	#print s3, the value of function
	la $a0, s3
	syscall

	move $a0, $t0

	li $v0, 1
	syscall

	li $v0, 10      # end program
    syscall


EVALUATE:
	lw $t0, 0($sp) #load x
	lw $t1, 4($sp) #load y
	lw $t2, 8($sp) #load a
	lw $t3, 12($sp) #load b
	lw $t4, 16($sp) #load c

	mul $t2, $t2, $t0 #multiply a by x
	mul $t2, $t2, $t0 #multiply ax by x
	mul $t3, $t3, $t0 #multiply b by x
	mul $t3, $t3, $t1 #multiply bx by y
	mul $t4, $t4, $t1 #multiply c by y
	mul $t4, $t4, $t1 #multiply cy by y

	add $v0, $t2, $t3 #ax2 + bxy
	add $v0, $v0, $t4 #ax2 + bxy + cy2

	jr $ra