.text 

main:

	li $t0, 10	#t0 = 10
	addi $sp, $sp, -4
	sw $t0, 1($sp)

	addi $sp, $sp, 4

	li $v0, 10		#exit
	syscall