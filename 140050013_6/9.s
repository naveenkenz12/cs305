.data

	.text
	.global	main

main:
	addf	f0,f1,f2	;add two floating value registers
	cvtf2d	f0,f2		;convert floting value to double
	trap	0			;exit