.data
	message: .asciiz "The sum of 2020 and 5227 is " 
.text
	addi $s0, $0, 2020
	addi $s1, $0, 5227
	add $a1, $s0, $s1
	li $v0, 56
	la $a0, message
	syscall
	
	
	
	