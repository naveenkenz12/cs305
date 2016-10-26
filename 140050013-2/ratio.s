.data
	s1: .asciiz "Enter numerator of r1 : "
	s2: .asciiz "Enter denominator of r1 : "
	s3: .asciiz "Enter numerator of r2 : "
	s4: .asciiz "Enter denominator of r2 : "
	s5: .asciiz "Sum is : "
	s6: .asciiz "/"

	.align 2

	ratio1: .word 0, 0 #default initialisation
	ratio2: .word 0, 0 #default initialisation

.text

main:
	la $s0, ratio1 # Address of ratio1 is obtained in $s0 for future use
	la $s1, ratio2 # Address of ratio2 is obtained in $s1 for future use

	li $v0, 4	#print s1, enter the numerator of r1
	la $a0, s1
	syscall

	li $v0, 5	#take input numerator of r1
	syscall

	sw $v0, 0($s0) #first 4 bytes of s0 as numerator of r1

	li $v0, 4	#print s2, enter the denominator of r1
	la $a0, s2
	syscall

	li $v0, 5	#take input denominator of r1
	syscall

	sw $v0, 4($s0) #next 4 bytes of s0 as denominator of r1

	li $v0, 4	#print s3, enter the numerator of r2
	la $a0, s3
	syscall

	li $v0, 5	#take input numerator of r2
	syscall

	sw $v0, 0($s1) #first 4 bytes of s0 as numerator of r2

	li $v0, 4	#print s4, enter the denominator of r2
	la $a0, s4
	syscall

	li $v0, 5	#take input denominator of r2
	syscall

	sw $v0, 4($s1) #next 4 bytes of s0 as denominator of r2

	move $a0, $s0	# copy s0 to a0
	move $a1, $s1	# copy s1 to a1

	jal ADD # call function
	
	li $v0, 4	#print s5, the sum is
	la $a0, s5
	syscall

	lw $a0, 0($s0)# to print numerator
	li $v0, 1
	syscall

	li $v0, 4# to print /
	la $a0, s6
	syscall

	lw $a0, 4($s0)# to print denominator
	li $v0, 1
	syscall

	li $v0, 10      # end program
    syscall


ADD:
	lw $t4, 0($a0) #load numerator of r1
	lw $t5, 4($a0) #load denominator of r1
	lw $t6, 0($a1) #load numerator of r2
	lw $t7, 4($a1) #load denominator of r2

	mul $t3, $t5, $t7 #denominator of addition
	mul $t0, $t4, $t7 #first part of numerator
	mul $t1, $t5, $t6 #second part of numerator
	add $t0, $t0, $t1 #numerator of addition

	sw $t0, 0($a0)
	sw $t3, 4($a0)

	jr $ra