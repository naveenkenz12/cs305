.data
	.align 2#word align
	list: .space 32 # space allocated for 8 integers(4byte each)
	s1: .asciiz "Enter 8 values : " #print for taking input
	s2: .asciiz "sum of the values at even locations is larger\n" #print if the sum of value of even location are greater
	s3: .asciiz "sum of the values at odd locations is larger\n" #print if the sum of value of odd locations are greater

.text

main:
	la $s0, list #$so points to the begining of list
	add $t0, $0, $0 #=initialize $t0 to 0
	addi $t1, $t0, 8 #initialize $t1 to 8
	add $t5, $0, $0##initialize sum of odd place to be 0
	add $t6, $0, $0#initialize sum of even place to be 0

	add $t7, $0, $0## to check if place is even or odd
					##initially 0 as first place is odd
					##1 for even place

	li $v0, 4
	la $a0, s1 #$ao store the string to be printed initially
	syscall #print on the console

	loop:
		bge $t0, $t1, exit # check if t1>=8, if yes jump to exit
		li $v0, 5	#take integer input
		syscall

		sw $v0, ($s0)	#store the input in the list


		## for odd place t0 will be even as t0 starts from 0
		## and for even place t0 will be odd
		bgt $t7, $0, sum_even	#if t7 is >0(i.e. 1)go to sum_even

		sum_odd:
			lw $t4, ($s0)	#load the current eneterd value
			add $t5, $t5, $t4	# add value to sum of odd place numbers
			addi $t7, $0, 1		#make t7 1
			j loop_increament	#skip sum_even

		sum_even:
			lw $t4, ($s0)	# load the current enterd value
			add $t6, $t6, $t4	#add value to sum of even place number
			add $t7, $0, $0 #make t7 0

		loop_increament:
			addi $s0, $s0, 4	# increase list element pointer by 4(each int is 4 byte)
			addi $t0, $t0, 1	# add t0 by 1 in every loop


			j loop # again jhump to loop

	exit:
		li $v0, 4

		bgt $t5, $t6, l2	# if sum of odd is greater than even of odd jump to l2

		l1:
			la $a0, s2	# print even string
			syscall
			move $a0, $t6#print the value
			li $v0, 1
			syscall
			li $v0, 10      # end program
    		syscall

		l2:
			la $a0, s3	# print odd string
			syscall
			move $a0, $t5#print the value
			li $v0, 1
			syscall
			li $v0, 10      # end program
    		syscall

