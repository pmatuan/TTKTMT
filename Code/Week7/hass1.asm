.data
message: .asciiz "Gia tri tuyet doi cua so nguyen: "
.text
main:
	li $a0, -20205227
	jal abs
	add $a1, $a0, $0
	li $v0, 56
	la $a0, message
	syscall
	li $v0, 10
	syscall 
abs:
	sub $v0, $0, $a0
	bltz $v0, done
	nop
	add $a0, $v0, $0
done:
	jr $ra




