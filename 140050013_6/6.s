.data

	.text
	.global	main

	saveR:	.space 	4

main:
	addi	r2,r0,10
	addi 	r3,r0,5		;r3 = r0(0) + 5
	sw		saveR, r3	;save r3 in saveR
	sw		saveR, r2
	lw		r1,saveR
	bnez 	r1,Loop 
	trap 	0

Loop:
	addi 	r3,r3,6		;r3 = r3 + 6
	trap 	0			;exit

	;Not Possible
	;after load word, when bnez is used ,
	;it not taking the value from Mem stage 
	;rather than it is waiting (R-stall), for 2 clock-cycle 
	;for its input in ID stage, which might be architecture dependent.

	;write to a register happens at rising edge and can be completed by atmost half of the cycle and 
	;read can happen through out the cycle, hence there is no need of forwarding