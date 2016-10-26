.data

	.text
	.global	main

main:
	addi 	r3,r0,5		;r3 = r0(0) + 5
	addi 	r1,r0,2		;r1=2
	div  	r3,r3,r1	;r3=r3/r1
	div 	r3,r3,r1
	trap 	0

	;39 steps
	;Divide two registers (r2=r2/r1) and again divide 
	;same(r2=r2/r1) and then exits, it will T-stall(waits) 
	;for clearing the pipeline before exits and thus waits for 39 clock cycles.