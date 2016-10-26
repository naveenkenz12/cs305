.data

	.text
	.global	main

main:
	addi 	r3,r0,5		;r3 = r0(0) + 5
	bnez 	r3,Loop		;if r3 !=0, go to Loop block
	addi 	r3,r0,5

Loop:
	addi 	r3,r3,6		;r3 = r3 + 6
	bnez 	r3,main
	addi 	r3,r3,1
	trap 	0			;exit
