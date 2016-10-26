.data
	s1:	.asciiz "Enter number to count number of set bits in: \n"
	s2:	.asciiz "Number of set bits = "
	s3: .asciiz "\n"
	.align 2

	.globl	main
	
	.text

main:
	li	$v0, 4		#print s1
	la	$a0, s1
	syscall

	li $v0, 5		#input n
	syscall

	add $s0, $v0, $0	#save n in $s0

	add $a0, $s0, $0	#a0=n, to be passed as arguement
	
	jal BitCount	#call function bitcount

	add	$t0, $v0, $0	#a0=result of function call

	li $v0, 4	#print s2
	la $a0, s2
	syscall

	li $v0, 1	#print result
	add $a0, $t0, $0
	syscall

	li $v0, 4	#print newline
	la $a0, s3
	syscall

	li $v0, 10	#exit
	syscall

BitCount:
	addi $sp, $sp, -8	#create space of 8 bytes in stack to save return address an bit
	sw $ra, 0($sp)	#store return address in stack

	add $t0, $a0, $0	#t0=n

	beq $t0, $0, ret_0	#if n=0, goto ret_0 block

	andi $t1, $t0, 1	#t1 = t0 & 1
	sw $t1, 4($sp)	#store t1 in stack

	srl $a0, $t0, 1		#a0 = n>>1

	jal BitCount     #recursive call to function

	lw $t2, 4($sp)	#load bit from stack
	add $v0, $v0, $t2	#bit = bit+new return 
	lw $ra, 0($sp)	#load return address from stack

	addi $sp, $sp, 8 #restore stack
	jr $ra #return	

	ret_0:
		lw $ra, 0($sp)	#load return address from stack		
		addi $sp, $sp, 8	#restore stack pointer

		add $v0, $0, $0	#v0 = 0
		jr $ra #return zero	

