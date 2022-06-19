# CS10 Lab 6
# Program to demonstrate MIPS ALU including the introduction of exception and interrupt handlers. 
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab6.asm
# Date:  11/08/20
# Registers Used:
# $a0 : holds address of my_name, my_fhID, result, $t1.

# $t2 : hold value of top bondary
# $t3 : hold value of each multiplication

.data 

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Foothill Student ID is 20383477\n"
result:		.asciiz	"The sum is: "

.text
main:
        # PRINT LAST NAME AND FOOTHILL ID
        
        la $a0, my_name       # load the addr of my_name into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
        la $a0, my_fhID       # load the addr of my_fhID into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
	#START THE CALCULATION
	
	li $t0, 1             # counter Start at 1
	li $t2, 20            # Set loop upperbound
        li $t1, 0             # Initialize sum
        
top_of_loop: bgt $t0, $t2, end_of_loop  # Break loop if $t0 exceeds upperbound

	addi	$t3,$t0,1     # $t3 = $t0 + 1
	mult	$t0,$t3	      # Lo = $t0 * $t3
	mflo	$t3	      # $t3 = Lo 
	add	$t1,$t1,$t3   # $t1 = $t1 + $t3
	addi	$t0, $t0, 1   # increment counter
	b	top_of_loop   # branch to top_of_loop

end_of_loop:

	li $v0, 4      	      # Perform the print_string
	la $a0, result        # using the result 
	syscall
	
	move $a0, $t1         # print sum result
	li $v0, 1	      # Prints_int
	syscall
	
	li $v0, 10            # exit syscall
	syscall
