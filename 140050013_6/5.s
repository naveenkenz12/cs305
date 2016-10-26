.data

	.text
	.global	main

main:
	addi 	r3,r0,5		;r3 = r0(0) + 5
	bnez 	r3,Loop		;if r3 !=0, go to Loop block

Loop:
	addi 	r3,r3,6		;r3 = r3 + 6
	trap 	0			;exit

	;in statement: addi r3,r0,5, the value of r3 is caluculated
	; in intEX state, but the next statement bnez r3,
	;Loop requires its input to be ready in ID stage only,
	;which is not ready by the previous statement till now.
	;So it makes R-Stall and wait for r3 to be ready (waits for previous statement executing intEX stage).
	;And when the input is ready it is forwarded from intEX stage of statement 1 to ID stage of statement 2.