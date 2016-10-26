	.file	1 "fibonacci.c"		#name of c file
	.text
	.align	2					#word aligned
	.globl	fibonacci
	.set	nomips16
	.ent	fibonacci
fibonacci:						#fibonacci function block
	.frame	$fp,40,$31			# vars= 0, regs= 3/0, args= 16, gp= 8
	.mask	0xc0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-40			#create 40 byte space into the stack
	sw	$31,36($sp)				#store return address into the stack
	sw	$fp,32($sp)				#store frame pointer into the stack
	sw	$16,28($sp)				#store $s0 into the stack
	move	$fp,$sp 			#copy the value of stack pointer to frame pointer
	sw	$4,40($fp)				#store a0 (arguement) into frame
	sw	$5,44($fp)				#store a1 (arguement) into frame
	sw	$6,48($fp)				#store a2 (arguement) into frame
	lw	$2,48($fp)				#load $v0 from frame
	#nop
	bgtz	$2,$L2				#if $v0>0 goto branch L2, else continue
	li	$2,1					# 0x1	#save $v0=1
	b	$L3						#jump to branh L3
$L2:							#block L2
	lw	$3,48($fp)				#load $v1 from frame
	li	$2,1					# 0x1	#save $v0=1
	bne	$3,$2,$L4				#if $v1 != $v0, jump to branch L4, else continue
	lw	$2,40($fp)				#load $v0 from frame
	b	$L3						#jump to branch L3
$L4:							#branch L4
	lw	$3,48($fp)				#load $v1 from frame
	li	$2,2					# 0x2	#save $v0=2
	bne	$3,$2,$L5				#if $v1 != $v0, jump to branch L5 else continue
	lw	$2,44($fp)				#load $v0 from stack
	b	$L3						#jump to branch L3
$L5:							#bloack L5
	lw	$2,48($fp)				#load $v0 from frame
	#nop
	addiu	$2,$2,-1			#$v0=$v0 - 1
	lw	$4,40($fp)				#load $a0 from frame
	lw	$5,44($fp)				#load $a1 from frame
	move	$6,$2				#move $v0 to $a2
	jal	fibonacci				#call function fibonacci
	move	$16,$2				#move $v0 to $s0
	lw	$2,48($fp)				#load $v0 from frame
	#nop
	addiu	$2,$2,-2			#$v0=$v0 - 2
	lw	$4,40($fp)				#load $a0 from frame
	lw	$5,44($fp)				#load a1 from frame
	move	$6,$2				#copy $v0 to $a2
	jal	fibonacci				#call fibonacci
	addu	$2,$16,$2			#add both result
$L3:							#blocl L3
	move	$sp,$fp				#move frame pointer value tpo stack poinetr
	lw	$31,36($sp)				#load return address from stack
	lw	$fp,32($sp)				#load frame pointer from stack
	lw	$16,28($sp)				#load $s0 from stack
	addiu	$sp,$sp,40			#restore stack
	j	$31						#return 
	.end	fibonacci			#end of fibonacci function
	.align	2
	.globl	main
	.set	nomips16
	.ent	main
main:							#main function block
	.frame	$fp,40,$31			# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-40			#create space of 40 bytes in stack
	sw	$31,36($sp)				#store return address into stack
	sw	$fp,32($sp)				#store frame poinrter from the stack
	move	$fp,$sp 			#copy value of stack pointer to frame pointer
	li	$4,1					# 0x1	#save a0=1
	li	$5,2					# 0x2	#save a1=2
	li	$6,10					# 0xa	#save a2=10
	jal	fibonacci				#call function fibonacci
	sw	$2,24($fp)				#store returned value($v0) into frame
	lw	$4,24($fp)				#load returned value($v0) from frame into $a0
	jal	syscall_print_int		#call function to print the result
	jal	syscall_print_newline	#call function to print the newline
	move	$sp,$fp				#copy the value of frame pointer to stack pointer
	lw	$31,36($sp)				#load return address from the stack
	lw	$fp,32($sp)				#load frame pointer from the stack
	addiu	$sp,$sp,40			#restore stack
	j	$31						#return
	.end	main				#end main function

.data
newline: .asciiz	"\n"		#new line character saved in string 
.align 2						#word aligned
result: .space 4				#result integer type(4 bytes required)

.text

syscall_print_int:				#function to print the value of result
	addi $sp, $sp, -4			#create 4 byte space in stack
	sw $ra, 0($sp)				#store the return address into the stack
	li	$v0, 1					# Using $a0 as argument
	syscall
	lw $ra, 0($sp)				#load return address from the stack
	addi $sp, $sp, 4			#restore the stack
	jr	$ra						#return address
	nop

syscall_print_newline:			#function to print new line character
	addi $sp, $sp, -4			#create 4 byte space in stack
	sw $ra, 0($sp)				#store return address into stack
	li	$v0, 4					#print newline
	la	$a0, newline
	syscall
	lw $ra, 0($sp)				#load return address from the stack
	addi $sp, $sp, 4			#restore stack
	jr $ra						#returmn address
	nop
