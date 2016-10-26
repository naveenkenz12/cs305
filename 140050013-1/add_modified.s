.text
.globl	main
	
main:
	lui	$t5, 0x1000
	ori $t5, $t5, 0x0001		
	lui	$t6, 0x2000
	ori	$t6, $t6, 0x0002
	add $t7, $t5, $t6
	
	li $v0, 10
	syscall

	.data
