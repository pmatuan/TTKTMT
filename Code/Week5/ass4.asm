.data
	string:	.space 50
	Message1:	.asciiz "Nhap xau: "
	Message2:	.asciiz "Do dai la: "
.text
main:
get_string:
	li $v0, 54
	la $a0, Message1
	la $a1, string
	la $a2, 50
	syscall
get_length:
	la $a0, string
	xor $t5, $0, $0
	xor $t0, $0, $0
check_char:
	add $t1, $a0, $t0
	lb $t2, 0($t1)
	beq $t2, $0, end_of_str
	addi $t5, $t5, 1
	addi $t0, $t0, 1
	j check_char
end_of_str:
addi $t5, $t5, -1
print_length:
	li $v0, 56
	la $a0, Message2
	add $a1, $t5, $0
	syscall
	
