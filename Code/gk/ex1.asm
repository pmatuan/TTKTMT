.data 
	Input: .space 51
	StringList: .space 1000

	Result: .asciiz "Ket qua:\n"
	Input_string_message: .asciiz "Nhap vao xau (duoi 50 ki tu): "
	Not_is_palidrome: .asciiz "Khong phai xau doi xung"
	Is_palindrome: .asciiz "La xau doi xung"
	Stored: .asciiz "Xau da duoc luu vao bo nho\n"
	Full_memory: .asciiz "Day bo nho!!!\n"
	Confirm: .asciiz "Ban co muon tiep tuc?\n"
	Store_string: .asciiz "Da luu xau vao bo nho!\n"
	Too_long: .asciiz "Xau qua dai!"
	ERROR: .asciiz "ERROR!!!\n"
	Space: .asciiz ""
.text
main:
#--------------------------------------------------------------------------------------------
# @brief	Nhận một xâu từ người dùng
#--------------------------------------------------------------------------------------------
getString:
	li $v0, 54
	la $a0, Input_string_message
	la $a1, Input
	la $a2, 51
	syscall
#--------------------------------------------------------------------------------------------
# @brief		Tìm độ dài của 1 xâu
# @param[in]	$s0	Địa chỉ của xâu cần tìm độ dài
# @param[out]	$s1	Độ dài của xâu
# @param[out]	$t1	Chỉ số của kí tự cuối cùng (Tính từ 0)
#--------------------------------------------------------------------------------------------
getLength:
	la $s0, Input
	addi $s1, $0, 0	
	addi $t1, $0, 0	
	iteration:
		add $t2, $s0, $t1
		lb $t3, 0($t2) 	
		
		beq $t3, $0,finishGetLength 
		
		addi $s7, $0, 10
		beq $t3, $s7, updateString
		
		addi $s1, $s1, 1
		addi $t1, $t1, 1
		j iteration
	updateString:
		add $t1, $s0, $t1
		sb $0, 0($t1)
	finishGetLength:
		add $t1, $0, $s1 	
		addi $t1, $t1, -1  	
#--------------------------------------------------------------------------------------------
# @brief		Kiểm tra độ dài xâu có lớn hơn 49 không
# @param[in]	$s1	Độ dài của xâu Input
# @param[out]		In ra thông báo nếu xâu dài hơn 49
#--------------------------------------------------------------------------------------------		
isTooLongString:
	slti $t2, $s1, 50
	beq $t2, $zero, putErrorStringMessage
#--------------------------------------------------------------------------------------------
# @brief		Kiểm tra xem xâu nhập vào có trong StringList không 
# @param[in]	$s0	Địa chỉ của Input
# @param[in]	$s2	Địa chỉ của StringList
# @param[out]	$t1	Chỉ số của kí tự cuối cùng của Input (Tính từ 0) 
# @param[out]	$t8	Giá trị của 0 hoặc 1, 1 là Input đã có trong StringList, 0 là chưa		
#--------------------------------------------------------------------------------------------
isStoredInMemory:		
	la $s2, StringList
	addi $t2, $zero, 0	
	addi $t8, $zero, 0	
		traverseRecentStringList:
		add $t5, $s2, $t2 	
		lb $t5, 0($t5)
		beq $t5, $zero, finishTraverseRecentStringList
		
		slti $t4, $t2, 1000
		beq $t4, $zero, finishTraverseRecentStringList
		addi $t3, $zero, 0	
		
		compareString:	
			add $t6, $s2, $t2	
			add $t6, $t6, $t3	
			lb $t6, 0($t6)		
			add $t7, $s0, $t3	
			lb $t7, 0($t7)		
			bne $t6, $t7, notEqual	
			beq $t6, $zero, isEqual 
			addi $t3, $t3, 1	
			j	compareString
			
			isEqual:
				addi $t8, $zero, 1
				j finishTraverseRecentStringList
			notEqual: 
				addi $t2, $t2, 50
				j traverseRecentStringList
			
	finishTraverseRecentStringList:
	bne $t8, $zero, putStringIsStoredMessage
			
#--------------------------------------------------------------------------------------------
# @brief		Kiểm tra xâu Input có phải xâu đối xứng không 
# @param[in]	$s0	Địa chỉ của Input 
# @param[in]	$s1	Độ dài của Input 
# @param[in]	$t1	Chỉ số của kí tự cuối cùng của Input (Tính từ 0)
# @param[out]		Thông báo in ra màn hình
#--------------------------------------------------------------------------------------------		
add $t1, $zero, $s1
addi $t1, $t1, -1 
addi $t2, $zero, 0	
checkPalindrome:		
		
	add $t3, $s0, $t2	
	lb $t3, 0($t3)		
	
	add $t4, $s0, $t1	
	lb $t4, 0($t4)		
	bne $t3, $t4, notIsPalindrome
	addi $t1, $t1, -1 	
	addi $t2, $t2, 1	
	slt $t5, $t2, $t1	
	beq $t5, $zero, isPalindrome
	j checkPalindrome
	
	notIsPalindrome:
		la $a1, Not_is_palidrome
		li $v0, 59
		la $a0, Result
		syscall
		j confirmDialog
	isPalindrome:
		la $a1, Is_palindrome
		li $v0, 59
		la $a0, Result
		syscall
		j storeStringInMemory
#--------------------------------------------------------------------------------------------
# @brief		Lưu trữ Input vào StringList 
# @param[in]	$s0	Địa chỉ của Input
# @param[in] 	$s2	Địa chỉ của StringList
# @param[in]	$s1	Độ dài của Input
# @param[in]	$t1	Chỉ số của kí tự cuối cùng của Input (Tính từ 0)
# @param[out]		Thông báo đã lưu xâu hoặc lỗi do bộ nhớ đầy 
#--------------------------------------------------------------------------------------------	
storeStringInMemory:
	addi $t1, $s1, -1 	
	addi $t2, $zero, 0 	
	addi $t6, $zero, 0 	
	findLastString:
		slti $t4, $t2, 1000
		beq $t4, $zero, putFullMemoryMessage	
		add $t3, $s2, $t2	
		lb $t3, 0($t3)
		beq $t3, $zero, copyString 
		addi $t2, $t2, 50	
		j findLastString
	copyString:
		slt $t5, $t1, $t6
		bne $t5, $zero, putFinishedStoreString
		add $t7, $t2, $t6	
		add $t7, $t7, $s2	
		add $t8, $t6, $s0	
		lb  $t8, 0($t8)
		sb $t8, 0($t7)					
		addi $t6, $t6, 1	
		j copyString
#--------------------------------------------------------------------------------------------
# @brief		Hiện ra các thông báo
# @param[out]		In thông báo ra màn hình 
#--------------------------------------------------------------------------------------------	
putFinishedStoreString:	
	li $v0, 4
	la $a0, Store_string
	syscall
	j confirmDialog
	
putStringIsStoredMessage:
	li $v0, 59
	la $a0, Stored
	la $a1, Space
	syscall
	j confirmDialog	
	
	li $v0, 59
	la $a1, Is_palindrome
	la $a0, Result
	syscall
		
	j confirmDialog			
		
putFullMemoryMessage:
	li $v0, 4
	la $a0, Full_memory
	syscall
	j confirmDialog
	
putErrorStringMessage:
	la $a1, Too_long
	li $v0, 59
	la $a0, ERROR
	syscall
	j main
#--------------------------------------------------------------------------------------------
# @brief		Hỏi ý kiến người dùng có muốn nhập tiếp không ? 
#			Ấn yes sẽ nhập tiếp
# @param[out]	$a0	0: Yes
#			1: No
#			2: Cancel
#--------------------------------------------------------------------------------------------		
confirmDialog:
	li $v0, 50
	la $a0, Confirm
	syscall
	beq $a0, $zero, main
	
