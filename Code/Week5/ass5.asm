.data
	string:	.space 20
	reverse: .space 20
	Message1:	.asciiz "Nhap xau: "
	Message2:	.asciiz "Xau dao nguoc la: "
.text
main:
get_string:
	li $v0, 54
	la $a0, Message1
	la $a1, string
	la $a2, 20
	syscall
get_length:
	la $a0, string
	xor $t0, $0, $0
check_char:
	add $t1, $a0, $t0
	lb $t2, 0($t1)
	beq $t2, $0, strcpy
	addi $t0, $t0, 1
	j check_char
strcpy:
	add $s0, $0, $0
	la $a3, reverse
L1:
	addi $t1, $t1, -1
	lb $t2, 0($t1)
	add $t3, $a3, $s0
	sb $t2, 0($t3)
	addi $s0, $s0, 1
	beq $s0, $t0, print
	nop
	j L1
	nop
print:
	li $v0, 59
	la $a0, Message2
	la $a1, reverse
	syscall


	
