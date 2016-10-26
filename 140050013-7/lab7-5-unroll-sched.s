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
	addi 	r21,r0,0	;R21=0, FOR INDEXING OFFSET CALCULATION
	addi 	r23,r0,-4	;R23=0, FOR INDEXING OFFSET CALCULATION, initialized with -4
						;so that first timne, it increament by 4, to make offset(r21=0)
						;in line 36

	addi 	r6,r0,alpha	;get alpha
	lw		r6,0(r6)

	loop:

		addi	r21,r23,4		;offset calculate increament by 4

		addi 	r22,r22,1		;i=i+1
		sub		r5,r22,r20		;calculate i-n

		lw		r8,a(r21)		;r8=a[i]
		lw 		r9,b(r21)		;r9=b[i]

		addi 	r23,r21,4		;increament offset to calculate i+1
		lw		r10,a(r23)		;r10=a[i+1]
		lw 		r11,b(r23)		;r11=b[i+1]

		mult	r8,r8,r9		;r8=a[i]*b[i]
		mult	r10,r10,r11		;r8=a[i+1]*b[i+1]

		lw		r9,d(r21)		;r9=d[i]
		lw		r12,d(r23)		;r12=d[i+1]

		mult 	r2,r8,r6		;r2=c[i]*alpha
		mult 	r3,r10,r6		;r3=d[i+1]*alpha
		add 	r9,r8,r2		;r9=d[i]+c[i]*alpha

		sw		c(r21),r8		;c[i]=a[i]*b[i]

		sw		d(r21),r9		;store d[i]

		beqz	r5,exit			;if i==n, exit the loop

		;unrolling twice

		addi 	r22,r22,1		;i=i+1
		sub		r5,r22,r20		;calculate i-n

		sw		c(r23),r10		;c[i]=a[i]*b[i]

		add 	r12,r10,r3		;r12=d[i]+c[i]*alpha
		sw		d(r23),r12		;store d[i]

		bnez	r5,loop			;if i!=n, continue the loop
		
	exit:
		trap  	0				;exit

