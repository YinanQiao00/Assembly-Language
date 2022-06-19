# CS10 Lab 8
# Program about Multitasking and Context Switching; Pipelining.
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab8.asm
# Date:  11/22/20
# Registers Used:
# $a0 : holds address of my_name, my_fhID.
# $t2 : hold value
# $t3 : hold value of sum of $3 and $2.
# $t4 : hold value of $3.
# $t6 : hold value that determine whether $3 and $4 are the same. 
# $t7 : hold value of difference of $6 and 2.

.data 

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Foothill Student ID is 20383477\n"

.text
main:
        # PRINT LAST NAME AND FOOTHILL ID
        
        la $a0, my_name       # load the addr of my_name into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
        la $a0, my_fhID       # load the addr of my_fhID into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
        add $3, $2, $3        # i1
        nop 		      # Need nop to avoid hazard as $3 been used again by i2
	lw $4, 100($3)        # i2
	sub $7, $6, $2        # i3
	nop                   # Need nop to avoid hazard as $6 been used again by i4
	xor $6, $4, $3        # i4
	
	li $v0, 10            #exit syscall
	syscall
