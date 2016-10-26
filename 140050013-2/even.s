.data
	.align 2#word align
	s1: .asciiz "Give a number : " #print for taking input
	s2: .asciiz " is not even\n" #print if the number is not even
	s3: .asciiz " is even\n" #print if the number is even

.text

main:
	li $v0, 4
	la $a0, s1 #$ao store the string to be printed initially
	syscall #print on the console
	
	li $v0, 5 # take integer input from user
	syscall
	move $t0, $v0 # store integer in t0

	add $a0, $t0, $0
	jal ISEVEN# call function
	add $t1, $v0, $0# if t1=1 then even else odd

	bgt $t1, $0, l4 # if t1>0 jump to l2
	
	l3:

		move $a0, $t0#print the value
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, s2 #$ao store the string to be printed finally
		syscall #print on the console
		li $v0, 10      # end program
    	syscall
		
	l4:
		move $a0, $t0#print the value
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, s3 #$ao store the string to be printed finally
		syscall #print on the console
		li $v0, 10      # end program
    	syscall


ISEVEN:
	andi $t2, $a0, 1# and with 1 to get the unit place
	# if t2 is 0 then even else odd
	bgt $t2, $0, l2 # if t2>0 jump to l2
	
	l1:
		addi $v0, $0, 1#return 1 in case of even
		j ret# jump to ret skip l1

	l2:
		add $v0, $0, $0#return 0 in  case of odd

	ret:
		jr $ra