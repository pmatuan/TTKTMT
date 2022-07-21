.data
	A: .word 2, 0, 2, 0, 9, 2, 2, 7
	n: .word 8
	Message: .asciiz "Tich lon nhat la: "
	Output: .asciiz "\nHai so: "
	Comma: .asciiz ", "
.text
	la $s0, A		#load địa chỉ của mảng A
	la $s2, n
	lw $s2, 0($s2)
	addi $s1, $0, -1 	#i
	addi $s2, $s2, -2 	#n-2
	addi $s3, $0, 1 	#step
	addi $s4, $0, 0 	#product
	j loop
#--------------------------------------------------------------------------------------------
# @brief		Khởi tạo giá trị cho tích lớn nhất
# @param[in]	$a1	Phần tử thứ nhất của mảng 
# @param[in]	$a2	Phần tử thứ hai của mảng
# @param[out]	$s4	Giá trị tích lớn nhất tính đến hiện tại
# @param[out]	$t3	Giá trị phần tử thứ nhất trong cặp phần tử đang xét	
# @param[out]	$t4	Giá trị phần tử thứ hai trong cặp phần tử đang xét
#--------------------------------------------------------------------------------------------
init:
	mult $a1, $a2		#Tích $a1 và $a2, được lưu vào thanh ghi $lo 
	mflo $s4			#Load giá trị của tích từ $lo vào $s4
	addi $t3, $a1, 0		#Lưu vết cửa phần tử thứ nhất 
	addi $t4, $a2, 0		#Lưu vết cửa phần tử thứ 2
	j check			#Kiểm tra điều kiện của vòng lặp
#--------------------------------------------------------------------------------------------
# @brief		Duyệt tất cả các cặp phần tử liền kế để tìm giá trị tích lớn nhất
# @param[in]	$s0	Địa chỉ của mảng A 
# @param[out]	$s5	Giá trị tích của cặp phần tử đang xét
# @param[out]	$t3	Giá trị phần tử thứ nhất trong cặp phần tử đang xét	
# @param[out]	$t4	Giá trị phần tử thứ hai trong cặp phần tử đang xét
#--------------------------------------------------------------------------------------------
loop:
	add $s1, $s1, $s3	#i = i + step
	add $t1, $s1, $s1	#t1 = 2*s1
	add $t1, $t1, $t1	#t1 = 4*s1
	add $t1, $t1, $s0	#t1 lưu địa chỉ của A[i] 
	lw $a1, 0($t1)		#load giá trị A[i] vào $a1
	lw $a2, 4($t1)		#load giá trị A[i+1] vào $a2
	beq $s1, $0, init	#Nếu $s1 = 0, tức là chạy lần đầu thì khởi tạo giá trị cho product
	mult $a1, $a2		#Tích $a1 và $a2, được lưu vào thanh ghi $lo 
	mflo $s5			#Lưu giá trị product hiện thời vào $s5 để so sánh
	slt $t2, $s4, $s5	#Nếu $s4 < $s5 => $t2 = 1, ngược lại $t2 = 0
	bne $t2, $0, swap	#$t2 = 1 => $s4 < $s5, giá trị tích lớn nhất được thay đổi
	j check
#--------------------------------------------------------------------------------------------
# @brief		Cập nhật giá trị tích lớn nhất
# @param[in]	$s5	Giá trị tích của cặp phần tử đang xét	
# @param[out]	$s4	Giá trị tích lớn nhất tính đến hiện tại	
# @param[out]	$t3	Giá trị phần tử thứ nhất trong cặp phần tử đang xét	
# @param[out]	$t4	Giá trị phần tử thứ hai trong cặp phần tử đang xét	
#--------------------------------------------------------------------------------------------
swap:
	addi $s4, $s5, 0	#Thay đổi giá trị tích lớn nhất
	addi $t3, $a1, 0	#Lưu vết của phần tử thứ nhất
	addi $t4, $a2, 0	#Lưu vết của phần tử thứ 2
#--------------------------------------------------------------------------------------------
# @brief		Kiểm tra điều kiện của vòng lặp
# @param[in]	$s1	Chỉ số của phần tử đang xét trong m?ng	
# @param[out]		Nhảy đến vòng lặp để tiếp tục duyết hoặc chuyển sang hàm print	
#--------------------------------------------------------------------------------------------
check:
	slt $t5, $s1, $s2	#Nếu i < n-2 thì $t5 = 1, ngược lại $t5 = 0
	bne $t5, $0, loop	#Nếu $t5 = 1 thì tiếp tục vòng lặp, nếu sai thì dừng vòng lặp
#--------------------------------------------------------------------------------------------
# @brief		In thông báo ra màn hình
# @param[in]	$s4	Giá trị tích lớn nhất	
# @param[in]	$t3	Giá trị phần tử thứ nhất trong cặp phần tử có tích lớn nhất
# @param[in]	$t4	Giá trị phần tử thứ hai trong cặp phần tử có tích lớn nhất
# @param[out]		In thông báo kết quả ra màn hình	
#--------------------------------------------------------------------------------------------
print:
	li $v0, 4		#In ra xâu 
	la $a0, Message		
	syscall
	li $v0, 1		#In ra tích lớn nhất
	addi $a0, $s4, 0
	syscall
	li $v0, 4
	la $a0, Output
	syscall
	li $v0, 1
	addi $a0, $t3, 0
	syscall
	li $v0, 4
	la $a0, Comma
	syscall
	li $v0, 1
	addi $a0, $t4, 0
	syscall
	li $v0, 10
	syscall
