# CS10 Lab 7
# Program have instruction causes the exception handlers be called. 
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab7.asm
# Date:  11/14/20
# Registers Used:
# $a0 : holds address of __m1_, __m2_, __m3_.
# $t1 : hold value of sum
# $t0 : hold value of counter
# $v0: holds addr sycalls.
# $k0: Holds address and exception code number

	.kdata
__m1_:	.asciiz "Exception caused by instruction at Address: "
__m2_:	.asciiz "\nException Code = "
__m3_:	.asciiz "\nIgnore and continue program ...\n"
s1:	.word 0
s2:	.word 0
# This is the exception vector address for MIPS32:
	.ktext 0x80000180
	
				# Save $v0, and $a0

	sw $v0 s1               # Not re-entrant and we can't trust $sp
	sw $a0 s2               # But we need to use these registers
	
	li $v0 4                # syscall 4 (print_str)
	la $a0 __m1_		# Print out Exception Address statement
	
	syscall

	li $v0 34               # Syscall 34 
	mfc0 $k0 $14            # Get Cause Address
	srl $a0 $k0 2           # Extract ExcCode Field
	andi $a0 $a0 0xf
	syscall
	
				# Print information about exception
	li $v0 4                # syscall 4 (print_str)
	la $a0 __m2_
	syscall
	
	li $v0 1                # syscall 1 (print_int)
	mfc0 $k0 $13            # Get Cause register
	srl $a0 $k0 2           # Extract ExcCode Field
	andi $a0 $a0 0xf
	syscall
	
				# Bad PC exception requires special checks
	bne $k0 0x18 ok_pc
	nop
	
	mfc0 $a0 $14            # EPC
	andi $a0 $a0 0x3        # Is EPC word-aligned?
	beq $a0 0 ok_pc
	nop

	li $v0 10               # Exit on really bad PC
	syscall

				#  PC is alright to continue
ok_pc:

	li $v0 4                # syscall 4 (print_str)
	la $a0 __m3_            # ignore message
	syscall

	srl $a0 $k0 2           # Extract ExcCode Field
	andi $a0 $a0 0xf
	bne $a0 0 ret           # 0 means exception was an interrupt
	nop
	
				# Return from (non-interrupt) exception. 
ret:

	mfc0 $k0 $14            # Get EPC register value
	addiu $k0 $k0 4         # Skip faulting instruction by skipping
	                        # forward by one instruction
                                # (Need to handle delayed branch case here)
	mtc0 $k0 $14            # Reset the EPC register

				# Restore registers and reset procesor state

	lw $v0 s1               # Restore $v0 and $a0
	lw $a0 s2

	mtc0 $0 $13             # Clear Cause register
	mfc0 $k0 $12            # Set Status register
	
	eret			# Return from exception on MIPS32
