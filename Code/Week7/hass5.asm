.data
Max: .asciiz "Max value: "
Min: .asciiz "\nMin value: "
Index: .asciiz "\nIndex: "
.text
init:
	li $s0, 5
	li $s1, 4
	li $s2, 10
	li $s3, 6
	li $s4, 30
	li $s5, 18
	li $s6, 3
	li $s7, -3

main:
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
findmaxmin:
	#a0: max index
	#a1: min index
	#a2: index
	#t0: max value
	#t1: min value
	add $t0, $s0, $0
	add $t1, $s0, $0
	addi $a2, $a2, -1
loop:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	addi $a2, $a2, 1
	bgt $a2, 8, end
	blt $t0, $s0, switch_max
	nop
	blt $s0, $t1, switch_min
	nop
	j loop
switch_max:
	add $t0, $s0, $0
	add $t3, $a2, $0
	j loop
switch_min:
	add $t1, $s0, $0
	add $t4, $a2, $0
	j loop
end:
	li $v0, 4
	la $a0, Max
	syscall
	li $v0, 1
	add $a0, $0, $t0
	syscall
	li $v0, 4
	la $a0, Index
	syscall
	li $v0, 1
	add $a0, $0, $t3
	syscall	 
	li $v0, 4
	la $a0, Min
	syscall
	li $v0, 1
	add $a0, $0, $t1
	syscall
	li $v0, 4
	la $a0, Index
	syscall
	li $v0, 1
	add $a0, $0, $t4
	syscall	 
	
	
	
	
	