.data
	#.align 2#word align
	s1: .asciiz "y" #string of length 2
	integer: .space 4

.text

main:
	
	li $v0, 5 # take integer input from user
	syscall
	move $t0, $v0 # store integer in t0

	la $t1, integer 
	sw $t0, 0($t1)

	li $v0, 10      # end program
    syscall

## eroor

#Exception occurred at PC=0x00400038
#Unaligned address in store: 0x10010003

#error because a int which is of 4 byte is trying to
#accomodate in the remaining space after string
#since string is only of length 1,
#it is not automatically word aligned
