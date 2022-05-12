.data
message: .asciiz "So nguyen lon nhat: "
.text
main:
	li $a0, 20
	li $a1, 40
	li $a2, 6
	jal max
	li $v0, 56
	la $a0, message
	add $a1, $s0, $0
	syscall 
	li $v0, 10
	syscall
max:
	add $s0, $a0, $0
	sub $t0, $a1, $s0
	bltz $t0, continue
	nop
	add $s0, $a1, $0
continue:
	sub $t0, $a2, $s0
	bltz $t0, end
	nop
	add $s0, $a2, $0
end:
	jr $ra

