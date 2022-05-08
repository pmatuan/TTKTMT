.data
	A: .word 1,4,5,9,-10,3
.text
	addi $s1, $0, -1 #i
	addi $s3, $0, 6 #n
	addi $s4, $0, 1 #step
	addi $s5, $0, 0 #max
	la $s2, A
loop:
	beq $s1, $s3, brea
	add $s1, $s1, $s4
	add $t1, $s1, $s1
	add $t1, $t1, $t1
	add $t1, $t1, $s2
	lw $t0, 0($t1)
	abs $t0, $t0
	slt $t2, $s5, $t0
	bne $t2, $0, if
	j loop
if:
	add $s5, $t0, $0
	j loop
brea:
	
	
	
