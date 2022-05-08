.data 
A: .word 7, -2, 5, 1, 5, 2, 0, 2, 0, 5, 2, 2, 7
Aend: .word 
space: .asciiz " "
.text
main:	la $a0, A #$a0 = Address(A[0])
	la $a1, Aend
	li $t3, 0
	lw $t4, 0($a0)
	addi $t4, $a0, 0
	li $s1, 13
	j sort	#sort
	nop
end_main:
sort:
	la $v0, ($a0)	#$v0 is first set to Address(A[0])
loop_i:
	beq $v0, $a1, print_loop	#if $v0 points to Aend then the array is sorted.
	nop
	lw $v1, ($v0)	#$v1 = A[i]
	la $t0, ($v0)	#$t0 = Address(A[j])
loop_j:
	beq $t0, $a0, end_j	#if $t0 reaches the first element of the array then stop looping
	nop
	lw $t1, -4($t0)	#$t1 = A[j - 1]
	slt $t2, $v1, $t1	#A[i](tmp) < A[j - 1]?
	beq $t2, $0, end_j	#if true then push A[j - 1] to A[j], else stop looping
	nop
	sw $t1, ($t0)	#A[j] = A[j -1]
	addi $t0, $t0, -4	#j--
	j loop_j
	nop
end_j:
	sw $v1, ($t0)	#A[j] = tmp, store the value to the empty element
	addi $v0, $v0, 4	#i++
	j loop_i
	nop
print_loop:
	li $v0, 1
	lw $a0, 0($t4)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $t4, $t4, 4
	addi $t3, $t3, 1
	bne $t3, $s1, print_loop
after_sort: 
	li $v0, 10 	#exit 
	syscall 
	
	
	
	
	