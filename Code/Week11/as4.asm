# Laboratory Exercise 11, Assignment 4
# Phan Minh Anh Tuan - 20205227
.eqv IN_ADDRESS_HEXA_KEYBOARD 		0xFFFF0012 
.eqv OUT_ADDRESS_HEXA_KEYBOARD 		0xFFFF0014 
.eqv COUNTER 		0xFFFF0013 	# Time Counter 
.eqv MASK_CAUSE_COUNTER 		0x00000400 	# Bit 10: Counter interrupt 
.eqv MASK_CAUSE_KEYMATRIX 0x00000800 		# Bit 11: Key matrix interrupt 

.data 
msg_keypress: .asciiz "  " 
msg_counter: .asciiz "Count inteval: " 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# MAIN Procedure 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
.text 
main: 
	#--------------------------------------------------------- 
	# Enable interrupts you expect 
	#--------------------------------------------------------- 
	# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim 
	li $t1, IN_ADDRESS_HEXA_KEYBOARD 
	li $t3, 0x80 		# bit 7 = 1 to enable 
	sb $t3, 0($t1)
	# Enable the interrupt of TimeCounter of Digital Lab Sim 
	li $t1, COUNTER 
	sb $t1, 0($t1) 
	
	xor $s0, $s0, $s0
Loop: 	nop 
	nop 
	nop
sleep: 	addi $v0,$zero,32 	# BUG: must sleep to wait for Time Counter
	li $a0,200 		# sleep 300 ms 
	syscall 
	nop 			# WARNING: nop is mandatory here. 
	b Loop 
end_main: 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
.ktext 0x80000180 
IntSR: 	#------------------------------------------------------- 
	# SAVE the current REG FILE to stack 
	#------------------------------------------------------- 
 	addi $sp,$sp,4	 # Save $ra because we may change it later 
	sw $ra,0($sp) 
	addi $sp,$sp,4	 # Save $at because we may change it later 
	sw $at,0($sp) 
	addi $sp,$sp,4 	# Save $v0 because we may change it later 
	sw $v0,0($sp) 
	addi $sp,$sp,4 	# Save $a0, because we may change it later 
	sw $a0,0($sp) 
	addi $sp,$sp,4 	# Save $t1, because we may change it later 
	sw $t1,0($sp) 
	addi $sp,$sp,4 	# Save $t3, because we may change it later
	sw $t3,0($sp) 
	  
dis_int:	li $t1, COUNTER 		# BUG: must disable with Time Counter 
	sb $zero, 0($t1) 
	# no need to disable keyboard matrix interrupt 
	#--------------------------------------------------------
	# Processing 
	#-------------------------------------------------------- 
get_caus:mfc0 $t1, $13 		# $t1 = Coproc0.cause 
IsCount:	li $t2, MASK_CAUSE_COUNTER# if Cause value confirm Counter.. 
	and $at, $t1,$t2 
	beq $at,$t2, Counter_Intr 
IsKeyMa:li $t2, MASK_CAUSE_KEYMATRIX # if Cause value confirm Key..
	and $at, $t1,$t2 
	beq $at,$t2, Keymatrix_Intr 
others: j end_process 		# other cases 

Keymatrix_Intr:  		# Processing Key Matrix Interrupt	 
get_cod:
row1:	li $t1, IN_ADDRESS_HEXA_KEYBOARD 
	li $t3, 0x81 	# check row 1 and re-enable bit 7 
	sb $t3, 0($t1) 	# must reassign expected row 
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb $a0, 0($t1) 
	beq $a0, $0, row2
	j prn_cod
	nop
row2:	li $t1, IN_ADDRESS_HEXA_KEYBOARD 
	li $t3, 0x82 	# check row 2 and re-enable bit 7 
	sb $t3, 0($t1) 	# must reassign expected row 
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb $a0, 0($t1) 
	beq $a0, $0, row3
	j prn_cod
	nop
row3:	li $t1, IN_ADDRESS_HEXA_KEYBOARD 
	li $t3, 0x84 	# check row 3 and re-enable bit 7 
	sb $t3, 0($t1) 	# must reassign expected row 
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb $a0, 0($t1) 
	beq $a0, $0, row4
	j prn_cod
	nop
row4:	li $t1, IN_ADDRESS_HEXA_KEYBOARD 
	li $t3, 0x88 	# check row 4 and re-enable bit 7 
	sb $t3, 0($t1) 	# must reassign expected row 
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb $a0, 0($t1) 
	j prn_cod
	nop
prn_cod:	li $v0,34 
	syscall
prn_msg:	addi $v0, $zero, 4 
	la $a0, msg_keypress 
	syscall
prn_count_intr:
	li $v0, 4 		
	la $a0, msg_counter 
	syscall 
	addi $v0, $zero, 1 
	add $a0, $s0, $zero 	# print auto sequence number 
	syscall
	addi $v0, $zero, 11 
	li $a0, '\n' 		# print endofline 
	syscall  
	add $s0, $0, $0
	j end_process 
Counter_Intr: 
	addi $s0, $s0, 1		# Processing Counter Interrupt
	j end_process 
end_process: mtc0 $zero, $13 	# Must clear cause reg 
en_int: 
	#-------------------------------------------------------- 
	# Re-enable interrupt 
	#-------------------------------------------------------- 
	li $t1, COUNTER 
	sb $t1, 0($t1) 
	#-------------------------------------------------------- 
	# Evaluate the return address of main routine 
	# epc <= epc + 4 
	#-------------------------------------------------------- 
next_pc:	
	mfc0 $at, $14 		# $at <= Coproc0.$14 = Coproc0.epc 
	addi $at, $at, 4 	# $at = $at + 4 (next instruction) 
	mtc0 $at, $14 		# Coproc0.$14 = Coproc0.epc <= $at

	#--------------------------------------------------------
	# RESTORE the REG FILE from STACK 
	#--------------------------------------------------------
restore:	lw $t3, 0($sp)		# Restore the registers from stack 
	addi $sp,$sp,-4 
	lw $t1, 0($sp) 		# Restore the registers from stack
	addi $sp,$sp,-4 
	lw $a0, 0($sp) 		# Restore the registers from stack 
	addi $sp,$sp,-4 
	lw $v0, 0($sp) 		# Restore the registers from stack 
	addi $sp,$sp,-4 
	lw $at, 0($sp) 		# Restore the registers from stack 
	addi $sp,$sp,-4
	lw $ra, 0($sp) 		# Restore the registers from stack 
	addi $sp,$sp,-4 

return: eret # Return from exception
