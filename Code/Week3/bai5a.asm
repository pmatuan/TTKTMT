.data
	A: .word 1,2,3,4,5
.text
	addi $s1, $0, -1 #i
	addi $s3, $0, 5 #n
	addi $s4, $0, 1 #step
	addi $s5, $0, 0 #sum
	la $s2, A
loop:
	add $s1, $s1, $s4
	add $t1, $s1, $s1
	add $t1, $t1, $t1
	add $t1, $t1, $s2
	lw $t0, 0($t1)
	bne $t0, $0, loop
	
	
	
