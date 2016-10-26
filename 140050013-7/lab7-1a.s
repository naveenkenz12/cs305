.data

		.global a
		.global b 
		.global c 
		.global d
		.global n
		.global alpha

a:		.word	1, 2, 3, 4, 5, 6 
b:		.word	2, 3, 4, 5, 6, 7
c:		.word	0, 0, 0, 0, 0, 0
d:		.word 	0, 0, 0, 0, 0, 0
n:		.word	6
alpha:	.word 10

	.text
	.global	main

main:

	addi	r20,r0,n	;load address of n

	lw		r20,(r20)	;store value of n
	addi	r22,r0,0	;initialize with 0
	addi 	r17,r0,4	;R17=4, FOR INDEXING OFFSET CALCULATION


	loop:
		sub		r5,r22,r20		;calculate i-n

		beqz	r5,exit			;if i==n, exit the loop
		mult	r21,r22,r17		;offset calculate mult by 4
		lw		r8,a(r21)		;r8=a[i]
		lw 		r9,b(r21)		;r9=b[i]
		mult	r8,r8,r9		;r8=r8*r9
		sw		c(r21),r8		;c[i]=a[i]*b[i]

		add 	r1,r0,r8		;;arguement to f
		jal 	f				;function call
		lw		r8,d(r21)		;r8=d[i]
		add 	r8,r8,r1		;r8=d[i]+return value of function
		sw		d(r21),r8		;store d[i]

		addi 	r22,r22,1		;i=i+1
		j 		loop			;continue loop

	exit:
		trap  	0				;exit

f:
	addi 	r5,r0,alpha			;get alpha
	lw		r5,0(r5)
	mult 	r1,r1,r5			;MULTIPLY WITH ALPHA AND RETURN
	jr 		r31