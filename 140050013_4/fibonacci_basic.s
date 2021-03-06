.data
	.align 2#word align
	s1: .asciiz "\n" #print newline
	
.text

main:
	li $a0, 1#a0=1, arguement to function
	li $a1, 2#a1=2
	li $a2, 10#a2=10

	jal fibonacci#function call

	move $a0, $v0#save return value to a0

	li $v0, 1#print value
	syscall

	li $v0, 4
	la $a0, s1 #print endline
	syscall #print on the console

	li $v0, 10      # end program
    syscall


fibonacci:
	addi $sp, $sp, -20#stack pointer
	sw $a0, 12($sp)#save a0 (a)
	sw $a1, 8($sp)#save a1 (b)
	sw $a2, 4($sp)#save a2 (n)
	sw $ra, 0($sp)#save return address in stack

	addi $t0, $0, 1#save t0=1
	addi $t1, $0, 2#save t1=2

	blt $a2, $t0, exit_0#if n<1 exit_0 loop
	beq $a2, $t0, exit_1#if n==1 exit_1
	beq $a2, $t1, exit_2#if n==2 exit_2

	exit_3:				#else goto exit_3
		lw $a0, 12($sp)#first
		lw $a1, 8($sp)#second
		lw $t2, 4($sp)#n

		addi $a2, $t2, -1#n=n-1
		jal fibonacci

		sw $v0, 16($sp)#save result in stack

		lw $t2, 4($sp)#n
		addi, $a2, $t2, -2#n=n-2
		jal fibonacci

		lw $t0, 16($sp)#load result of previous

		add $v0, $v0, $t0#f(n-1)+f(n-2)

		lw $ra, 0($sp)#lod return address
		addi $sp, $sp, 20#restore stack

		jr $ra

	exit_0:
		addi $v0, $0, -1#v0=1
		lw $ra, 0($sp)#load return address
		addi, $sp, $sp, 20#restore stack
		jr $ra

	exit_1:
		add $v0, $0, $a0#if n==1 return first
		lw $ra, 0($sp)#load return address
		addi, $sp, $sp, 20#restore stack
		jr $ra

	exit_2:
		add $v0, $0, $a1#if n==2 return second
		lw $ra, 0($sp)#load return address
		addi, $sp, $sp, 20#restore stack
		jr $ra