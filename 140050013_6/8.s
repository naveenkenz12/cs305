.data

	.text
	.global	main

main:
	addi 	r3,r0,5		;r3 = r0(0) + 5
	addi 	r1,r0,2		;r1=2
	div  	r3,r3,r1	;r3=r3/r1
	
	;18 nop instructions
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	beqz 	r3,Loop		;if r3=0, goto Loop

Loop:
	trap 	0	;exit

;18 steps
	;first divide and use the result in bnez, 
	;division takes this much step in intEx stage, 
	;and thus the nez waits for 18 steps to get its input ready before its ID stage.