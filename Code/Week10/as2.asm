.eqv MONITOR_SCREEN 	0x10010000 	#Dia chi bat dau cua bo nho man hinh 
.eqv RED 		0x00FF0000 	#Cac gia tri mau thuong su dung 
.eqv GREEN 		0x0000FF00 
.eqv BLUE 		0x000000FF 
.eqv WHITE 		0x00FFFFFF 
.eqv YELLOW 		0x00FFFF00 
.data add .word
.text 
	li $k0, MONITOR_SCREEN 		#Nap dia chi bat dau cua man hinh 
	
	li $t0, RED 
	sw $t0, 36($k0) 
	nop 
	li $t0, RED 
	sw $t0, 40($k0) 
	nop 
	li $t0, RED 
	sw $t0, 44($k0) 
	nop 
	li $t0, RED 
	sw $t0, 48($k0) 
	nop 	
	li $t0, RED 
	sw $t0, 52($k0) 
	nop 
	li $t0, RED 
	sw $t0, 76($k0) 
	nop 
	li $t0, RED 
	sw $t0, 108($k0) 
	nop 
	li $t0, RED 
	sw $t0, 140($k0) 
	nop 
	li $t0, RED 
	sw $t0, 172($k0) 
	nop 

	li $t0, WHITE
	addi $t1, $k0, 0
	addi $t3, $k0, 256 
loop:
	lw $t2, 0($t1)
	bne $t2, $0, next
	sw $t0, 0($t1)
next:
	addi $t1, $t1, 4
	beq $t1, $t3, done
	j loop	
done: