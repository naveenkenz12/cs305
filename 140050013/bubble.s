.data
	s1:	.asciiz "Enter the number of integers: \n"
	s2:	.asciiz "Enter "
	s3: .asciiz	" integers: \n"
	s4:	.asciiz	"Sorted list of "
	s5: .asciiz " integers in ascending order: \n"
	s6: .asciiz "\n"
	.align 2

	array: .space 400

	.globl	main
	
	.text

main:
	li	$v0, 4		#print s1
	la	$a0, s1
	syscall

	li $v0, 5		#input n
	syscall

	add $s0, $v0, $0	#save n in $s0

	li	$v0, 4		#print s2
	la	$a0, s2
	syscall

	li	$v0, 1		#print n
	add $a0, $s0, $0
	syscall

	li	$v0, 4		#print s3
	la	$a0, s3
	syscall

	la $t0, array	#t0 contain the address of array
	add $t1, $0, $0	#t1=0, counter for number of integer that has been taken as input

	loop:
		beq $t1, $s0, exit	#when t2=n, exit the loop
		li	$v0, 5		#input integer
		syscall

		sw $v0, ($t0)	#store in array
		addi $t0, $t0, 4	#increament array counter by 4
		addi $t1, $t1, 1	#increament number of integres input by 1

		j loop	#return again in loop

	exit:
		la $a0, array	#array address in a0 to pass as parameter to function bubble
		add $a1, $s0, $0	#a1 = n

		jal bubble	#function call

		li	$v0, 4		#print s4
		la	$a0, s4
		syscall

		li	$v0, 1		#print n
		add $a0, $s0, $0
		syscall

		li	$v0, 4		#print s5
		la	$a0, s3
		syscall		

		la $t0, array	#t0 contains the address of array
		add $t1, $0, $0	#t1=0, counter for numbers printed

		print_loop:
			beq $t1, $s0, exit_print #exit loop affter printing n numbers

			li $v0, 1
			lw $a0, ($t0)	#print array[i]
			syscall

			li $v0, 4	#print newline
			la $a0, s6
			syscall

			addi $t0, $t0, 4	#increament array counter by 4
			addi $t1, $t1, 1	#increament number of integres input by 1

			j print_loop	#goto primnt_loop again

		exit_print:
			li $v0, 10	#exit
			syscall

bubble:
	addi $sp, $sp, -4	#create space of 4 bytes in stack to save return address
	sw $ra, 0($sp)		#store return address in stack

	add $t0, $a0, $0	#t0 contains the address of array
	add $t1, $a1, $0	#t1 = n, total number of integers in array

	add $t2, $0, $0		#initialize t2 with 0

	addi $t3, $t1, -1	#t3 = n-1

	loop_bubble:
		beq $t2, $t3, exit_bubble	#continue in branch till t2<t3, else exit
		add $t4, $0, $0		#initialize t4 with 0
		sub $t5, $t3, $t2	#t5= n-1-c

		inner_loop:
			beq $t4, $t5, inner_exit	#exit ciondition for inner loop

			addi $t6, $0, 4		#t6=4
			mul $t6, $t4, $t6	#calculate offset for array[d]

			add $t6, $t0, $t6	#t6 points to array[d]
			lw $t1, ($t6)	#t1=array[d]

			addi $t6, $0, 4		#t6=4
			mul $t6, $t4, $t6	#calculate offset for array[d]

			add $t6, $t0, $t6	#t6 points to array[d]
			addi $t6, $t6, 4	#t6 points to address of array[d+1]
			lw $t7, ($t6)	#t7=array[d+1]

			bge	$t7, $t1, else	#if array[d+1]>=array[d] goto else
			if:
				#array[d]>array[d+1] then call swap function
				addi $t6, $0, 4		#t6=4
				mul $t6, $t4, $t6	#calculate offset for array[d]
				add $t6, $t0, $t6	#t6 points to array[d]
				add $a0, $t6, $0

				addi $t6, $0, 4		#t6=4
				mul $t6, $t4, $t6	#calculate offset for array[d]
				add $t6, $t0, $t6	#t6 points to array[d]
				addi $t6, $t6, 4	#t6 points to address of array[d+1]
				add $a1, $t6, $0

				jal swap

			else:
				addi $t4, $t4, 1	#t4++
				j inner_loop	#goto inner_loop again

		inner_exit:
			addi $t2, $t2, 1	#t2++
			j loop_bubble	#goto outer_loop again

	exit_bubble:
		lw $ra, 0($sp)	#load return address from stack
		addi $sp, $sp, 4	#restore the stack
		jr $ra 		#return

swap:
	lw $t6, ($a0)	#t6 = value of array[d]
	lw $t7, ($a1)	#t7 = value of array[d+1]

	sw $t6, ($a1)	#swap value between two addresses
	sw $t7, ($a0)

	jr $ra		#return