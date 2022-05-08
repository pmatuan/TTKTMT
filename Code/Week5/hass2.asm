.data 
	x: .space 1000
	y: .asciiz "Linh"
.text
la $a0, x
la $a1, y
strcpy:
	add $s0, $0, $0
L1:
	add $t1, $s0, $a1
	lb $t2, 0($t1)
	add $t3, $s0, $a0
	
	sb $t2, 0($t3)
	beq $t2, $zero, end
	nop
	addi $s0, $s0, 1
	j L1
	nop
end: