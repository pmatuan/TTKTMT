.data
	input: .space 31
	list: .space 310
	
	result: .asciiz "Ket qua: "
	input_message: .asciiz "Nhap vao xau (duoi 30 ki tu): "
	not_palidrome: .asciiz "Khong phai la xau doi xung !\n"
	palidrome: .asciiz "Xau doi xung\n"
	too_long: .asciiz "Xau qua dai!\n"
	stored: .asciiz "Xau da duoc luu vao bo nho !\n"
	full_memory: .asciiz "Day bo nho !\n"
	confirm: .asciiz "Ban co muon tiep tuc ?\n"
	ERROR: .asciiz "ERROR!!!\n"
	CONFIRM_MESSAGE: .asciiz "Do you want to continue?\n"
	SPACE: .asciiz ""
.text
main:

#Nhận một xâu từ người dùng
getString:
	li $v0, 54
	la $a0, input_message
	la $a1, input
	la $a2, 31
	syscall

#Lấy độ dài của xâu 
getLength:
	la $s0, input
	add $s1, $0, $0		#$s1 = length (i) = 0
checkChar:
	add $s2, $s0, $s1	#$s2 = Address(string[0]+i)
	lb $s3, 0($s2)
	beq $s3, $0, end_str
	addi $s1, $s1, 1
	j checkChar
end_str:

#Kiểm tra độ dài của xâu
isTooLongString:
	slti $t2, $s1, 30	#$s1 > 30 ? 
	beq $t2, $zero, putErrorStringMessage
#kiểm tra xâu đã được lưu chưa
isStored:
	la $s2, list
	addi $t2, $zero, 0	#t2 = j = 0
	addi $t8, $zero, 0	#t8 = check = 0
	traverseList:
		add $t5, $s2, $t2	#t5 = List + j
		lb $t5, 0($t5)
		beq $t5, $zero, finish_traverseList
		slti $t4, $t2, 310
		beq $t4, $zero, finish_traverseList
		addi $t3, $zero, 0	#t3 = k = 0
	compareString:	
		#compare char of 2 string
		add $t6, $s2, $t2	#t6 = List + j
		add $t6, $t6, $t3	#t6 = t6 + k
		lb $t6, 0($t6)		#t6 = List[j+k]
		add $t7, $s0, $t3	#t7 = input + k
		lb $t7, 0($t7)		#t7 = input[k]
		bne $t6, $t7, notEqual	#input[k]!=List[j+k]='\0'->not equal
		beq $t6, $zero, isEqual #input[k]=List[j+k]='\0'->equal
		addi $t3, $t3, 1	#k++
		j	compareString
			
		isEqual:
			addi $t8, $zero, 1
			j finish_traverseList
		notEqual: 
			addi $t2, $t2, 50
			j traverseList
	finish_traverseList:
	#if t8 = 1, thong bao da co string nay trong memory	
	bne $t8, $zero, putStringIsStoredMessage


add $t1, $zero, $s1
addi $t1, $t1, -1 
addi $t2, $zero, 0	#t2 = j = 0
checkPalindrome:		
		
	add $t3, $s0, $t2	#t3 = input + t2
	lb $t3, 0($t3)		#t3 = input[0]
	
	add $t4, $s0, $t1	#t4 = input + t1
	lb $t4, 0($t4)		#t4 = input[length]
	bne $t3, $t4, notIsPalindrome
	addi $t1, $t1, -1 	#i--
	addi $t2, $t2, 1	#j++
	slt $t5, $t2, $t1	#j < i?
	beq $t5, $zero, isPalindrome
	j checkPalindrome
	
	notIsPalindrome:
		la $a1, not_palidrome
		li $v0, 59
		la $a0, RESULT
		syscall
		j confirmDialog
		isPalindrome:
		la $a1, palidrome
		li $v0, 59
		la $a0, result
		syscall
		j storeStringInMemory
		
	

putErrorStringMessage:
	la $a1, too_long
	li $v0, 59
	la $a0, ERROR
	syscall
	#j main
putStringIsStoredMessage:
	li $v0, 59
	la $a0, stored
	la $a1, SPACE
	syscall
	
	li $v0, 59
	la $a1, palidrome
	la $a0, result
	syscall
		
	j confirmDialog	
confirmDialog:
	li $v0, 50
	la $a0, CONFIRM_MESSAGE
	syscall
	beq $a0, $zero, main	
end:
	
	
	
	
