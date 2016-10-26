	.file	1 "gcd.c"		#name of c file
	.text
	.align	2				#word align
	.globl	gcd			
	.set	nomips16
	.ent	gcd
gcd:						#block gcd
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-8		#create space of 8 bytes in stack
	sw	$fp,4($sp)			#store frame pointer in stack
	move	$fp,$sp 		#copy value of stack pointer into frame pointer(begining of stack)
	sw	$4,8($fp)			#$4=$a0, save the arguement a0 in frame
	sw	$5,12($fp)			#$5=$a1, save the arguement a1 in frame
$L5:						#block L5
	lw	$3,8($fp)			#load $v1 from frame
	lw	$2,12($fp)			#load $v0 from frame
	#nop
	bne	$3,$2,$L2			#if v1 != v2 goto block L2
	lw	$2,8($fp)			#load $v0 from the frame
	move	$sp,$fp			#copy value of frame pointer to stack pointer
	lw	$fp,4($sp)			#load value of frame pointer from the stack
	addiu	$sp,$sp,8		#restore stack
	j	$31					#return address($ra)
$L2:						#block L2
	lw	$3,8($fp)			#load v1 from frame
	lw	$2,12($fp)			#load v0 from frame
	#nop
	slt	$2,$2,$3			#if v0 < v1, set v0=1
	beq	$2,$0,$L3			#if v0=0, goto block L3 , else continue
	lw	$3,8($fp)			#load $v1 from frame
	lw	$2,12($fp)			#load $v0 from frame
	#nop
	subu	$2,$3,$2		#subtract ($v0 = $v1 - $v0)
	sw	$2,8($fp)			#store value of $v0 into frame
	b	$L5					#goto branch L5
$L3:						#block L3
	lw	$3,12($fp)			#load $v1 from frame
	lw	$2,8($fp)			#load $v0 from frame
	#nop
	subu	$2,$3,$2		#subtract ($v0 = $v1 - $v0)
	sw	$2,12($fp)			#store v0 into frame
	b	$L5					#goto branch L5
	.end	gcd				#end function gcd
	.align	2				#word align
	.globl	main
	.set	nomips16
	.ent	main
main:
	.frame	$fp,48,$31			# vars= 16, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-48			#create space of 48 bytes in stack, move stack pointer by 48 bytes
	sw	$31,44($sp)				#$31=$ra, store return address in stack
	sw	$fp,40($sp)				#store frame pointer into stack, 4 byte ahead of begining of stack
	move	$fp,$sp 			#move frame pointer to begining of stack, copy value of stack pointer to frame pointer
	li	$2,10					# 0xa	#saves $2($v0) = 10
	sw	$2,32($fp)				#store $2=10, into frame
	li	$2,75					# 0x4b	#saves $2($v0) = 75
	sw	$2,28($fp)				#store 75 into frame
	lw	$4,32($fp)				#load 10 in arguement $a0
	lw	$5,28($fp)				#load 75 in arguement $a1
	jal	gcd						#call function gcd with arguement $a0(10) and $a1(75)
	sw	$2,24($fp)				#store $v0(return value) into the frame
	lw	$4,24($fp)				#load returned value in a0 from the frame 
	jal	syscall_print_int		#call function to print the value
	jal	syscall_print_newline	#call function to print newline
	move	$sp,$fp				#copy the value of frame pointer to stack pointer
	lw	$31,44($sp)				#load return address($31=$ra) from the stack
	lw	$fp,40($sp)				#load frame pointer from the stack
	addiu	$sp,$sp,48			#restore stack pointer
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
