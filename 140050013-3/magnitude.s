.data
	s1: .asciiz "Enter the length of array A : "
	s2: .asciiz "Enter the elements of array : "
	s3: .asciiz "Enter start : "
	s4: .asciiz "Enter end : "
	s5: .asciiz "Maximum magnitude is : "
	s6: .asciiz " and its frequency is : "

	.align 2

	n: .word 0#length of array
	array: .space 160 #maximum 20 elements allowed

.text

main:
	la $s6, n #$so points to the begining of n
	la $s7, array#s1 points to begining of the array
	add $t0, $0, $0 #=initialize $t0 to 0

	li $v0, 4
	la $a0, s1 #$ao store the string to be printed initially
	syscall #print on the console

	li $v0, 5 # take integer input from user(length of array)
	syscall

	sw $v0, 0($s6) #store n

	add $t1, $t0, $v0 #initialize $t1 to length of array n

	li $v0, 4
	la $a0, s2 #$ao store the string to be printed initially
	syscall #print on the console

	loop:
		bge $t0, $t1, exit # check if t1>=n, if yes jump to exit
		li $v0, 5	#take integer input x
		syscall

		sw $v0, ($s7)
		addi $s7, $s7, 4#increament array pointer by 4


		li $v0, 5	#take integer input y
		syscall

		sw $v0, ($s7)	#store the input in the list

		addi $s7, $s7, 4#increament array pointer by4, as each integer is 4 bytes long
		addi $t0, $t0, 1#increament t1 by 1

		j loop

	exit:
		li $v0, 4
		la $a0, s3 #enetr start
		syscall #print on the console		

		li $v0, 5 # take start
		syscall

		add $t4, $v0, $0# t4 stores start

		li $v0, 4
		la $a0, s4 #enetr end
		syscall #print on the console		

		li $v0, 5 # take end
		syscall

		add $t5, $v0, $0# t5 stores end

		add $a0, $t4, $0#a0 contains start to be passed to function
		add $a1, $t5, $0#a1 contains end to be passed to function
	
	jal maximumMagnitude # call function

	move $t0, $v0	#print answer
	move $t1, $v1
	
	li $v0, 4	#print s5, the value of function(max magnitude)
	la $a0, s5
	syscall

	move $a0, $t0

	li $v0, 1
	syscall

	li $v0, 4	#print s6, the value of function(frequency of max magnitude)
	la $a0, s6
	syscall

	move $a0, $t1

	li $v0, 1
	syscall

	li $v0, 10      # end program
    syscall

maximumMagnitude:
	add $s1, $a0, $0#s1 = start
	add $s2, $a1, $0#s2 = end

	add $sp, $sp, -4#stack pointer shift by 4, to store the return address
	sw $ra, 0($sp)# store the return address

	la $s3, array#s3 points to starts of array

	addi $t0, $0, 8#2*4
	mul $t0, $s1, $t0
	add $s3, $s3, $t0#point to "start" of vector

	addi $s4, $0, -1#max element
	add $s5, $0, $0#frequency

	loop_f:
		bgt $s1, $s2, exit_f#loop exit condition
		lw $a0, ($s3)
		addi $s3, $s3, 4
		lw $a1, ($s3)
		addi $s3, $s3, 4

		jal magnitude

		bgt $v0, $s4, gt#if new magnitude is greater jump to gt
		beq $v0, $s4, eq#if equal jump to eq
		blt $v0, $s4, els#skip gt and eq if new val is less than min

		gt:
			move $s4, $v0#update max
			addi $s5, $0, 1#freq=1

			j els#skip eq

		eq:
			addi $s5, $s5, 1#freq++

			j els

		els:
			addi $s1, $s1, 1#increase loop variable by 1

			j loop_f

	exit_f:
		lw $ra, 0($sp)#store original ra
		add $v0, $s4, $0#max val
		add $v1, $s5, $0#freq

		jr $ra

magnitude:
	add $t0, $a0, $0#t0 = vec.a
	add $t1, $a1, $0#t1 = vec.b

	mul $t0, $t0, $t0#t0=a*a
	mul $t1, $t1, $t1#t1=b*b
	add $v0, $t0, $t1#v0=a*a + b*b

	jr $ra
