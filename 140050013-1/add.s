.text
.globl	main
	
main:
	li	$t5, 1		
	li	$t6, 2
	add $t4, $t5, $t6
	
	# for exit
	li $v0, 10
	syscall

	.data
