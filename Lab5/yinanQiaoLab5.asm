# CS10 Lab 5
# Program to demonstrate how to call functions and manage the stack frame in MIPS.
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab5.asm
# Date:  11/02/20
# Registers Used:
# $a0 : holds address of my_name, my_fhID, my_ave, my_digit, $t7, $t0
# $t0 : hold average value of num1 and num2, and last digit of my student id
# $t1 : hold sum of num1 and num2
# $t2 : hold value of sum
# $t7 : hold average value of num1 and num2
# $v0 : hold print_str syscall
# $s0 : hold the value num1 which is 12
# $s1 : hold the value num2 which is 16
# $sp : stack pointer
# $ra : return address

	.data 

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Foothill Student ID is 20383477\n"
my_ave:	        .asciiz "Average of two numbers is:\n"
my_digit:	.asciiz "\nMy Foothill Student ID's Last digit is is:\n"

	.text
main:
        #1. PRINT LAST NAME AND FOOTHILL ID
        
        la $a0, my_name   	# load the addr of my_name into $a0.
        li $v0, 4        	# 4 is the print_string syscall.
        syscall          	# do the syscall.
        
        la $a0, my_fhID   	# load the addr of my_fhID into $a0.
        li $v0, 4        	# 4 is the print_string syscall.
        syscall           	# do the syscall.
        
        #2. LOAD IMMEDIATE VALUE INTO SAVE REGISTERS.
        
        li $s0, 12	  	#store immediate num1=12 into $s0.
	li $s1, 16 		#store immediate num2=16 into $s1.
	
	# FRAME STACK
	subu $sp, $sp, 8        # Build our stack frame
	sw $s0, 0($sp)		# Push $s0 to the stack
	sw $s1, 4($sp)		# Push $s1 to the stack
	
	jal yq_avg
	
	#5. SAVE RESULT
	lw $t7, 0($sp)		# Get the result after average off of the stack
	addi $sp, $sp, 4	# break stack
	
	# Test result
	la $a0, my_ave   	# load the addr of my_name into $a0.
        li $v0, 4        	# 4 is the print_string syscall.
        syscall          	# do the syscall.
        
	la $a0, ($t7) 	        # load $t7 into $a0.
        li $v0, 1       	# 4 is the print_string syscall.
        syscall          	# do the syscall.
        
        la $a0, my_digit   	# load the addr of my_fhID into $a0.
        li $v0, 4        	# 4 is the print_string syscall.
        syscall           	# do the syscall.
        
        la $a0, ($t0)  	        # load $t0 into $a0.
        li $v0, 1        	# 4 is the print_string syscall.
        syscall          	# do the syscall.
	
	li $v0, 10              # exit
	syscall

	
yq_avg:
	#3. CALCULATE THE AVERAGE
	
	lw $s0, 0($sp)		# Pop $s0 off of the stack
	lw $s1, 4($sp)		# Pop $s1 off of the stack
	addi $sp, $sp, 8	# Free space from stack
	
	add $t1, $s0, $s1	# Calculate sum of two operands
	divu $t0, $t1, 2	# Claculate average and save it to $t0
	
	subu $sp, $sp, 4	# Decrement $sp by 4
	sw $t0, 0($sp)		# Store the average result onto the stack. 
	
	li $t0, 7		# Load the immediate rightmost digit of my student id
	jr $ra			# return to caller
	
	
	
	
        