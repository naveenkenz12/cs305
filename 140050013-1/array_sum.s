    .data
N: .word 5
X: .word 2, 4, 6, 8, 10
SUM: .word 0
    .text
    .globl  main
  
main:
    la $t5, X 
    lw $t6, N 
    li $t7, 0 

sumLoop:
    lw $t3, ($t5)
    add $t7, $t7, $t3
    addu $t5, $t5, 4 
    sub $t6, $t6, 1  
    bnez $t6, sumLoop

sw $t7, SUM  

li $v0,10 
syscall
