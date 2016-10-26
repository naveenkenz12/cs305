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

	addi 	r6,r0,alpha	;get alpha
	lw		r6,0(r6)

	loop:

		mult	r21,r22,r17		;offset calculate mult by 4
		
		addi 	r22,r22,1		;i=i+1
		sub		r5,r22,r20		;calculate i-n

		lw		r8,a(r21)		;r8=a[i]
		lw 		r9,b(r21)		;r9=b[i]
		mult	r8,r8,r9		;r8=r8*r9

		mult 	r2,r8,r6		;r1=c[i]*alpha
		sw		c(r21),r8		;c[i]=a[i]*b[i]
		
		lw		r8,d(r21)		;r8=d[i]

		add 	r8,r8,r2		;r8=d[i]+c[i]*alpha
		sw		d(r21),r8		;store d[i]
		
		bnez	r5,loop			;if i!=n, continue the loop
		trap  	0				;exit



;change wrt previos code 2a.
;line 35 and 36
;i=i+1
;and r5=i-n which will be checked to be 0, in last statement
;bnez , calculated initially rather than at last
;thsi decrease the number of stalls, as mult in line 33
;will take longer in intEX stage, thus lw in line 38 will have to 
;wait for its input r21 (index of array) to get ready,
;so lw can be postponed, instructions which does not require
;output of mult can be done before lw
