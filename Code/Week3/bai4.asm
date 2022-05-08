.text
	addi $s1, $0, 0x5227 #i
	addi $s2, $0, 0x5231 #j
	addi $t4, $0, 1
start:
	slt $t0, $s1, $s2
	bne $t0, $t4, else
	addi $t1, $t1, 1
	addi $t3, $zero, 1
	j endif
else:
	addi $t2, $t2, -1
	add $t3, $t3, $t3
endif: 


