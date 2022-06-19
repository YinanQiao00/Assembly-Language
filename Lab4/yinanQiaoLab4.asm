# CS10 Lab 4
# Program to demonstrate Demonstrate ability use loops and user input in MIPS.
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab4.asm
# Date:  10/16/20
# Registers Used:
# $a0 : holds address of my_name, my_fhID, prompt, result
# $t1 : hold value of counter
# $t2 : hold value of sum
# $t0 : hold value of top bondary

.data 

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Foothill Student ID is 20383477\n"
prompt:	        .asciiz	"Enter top value: "
result:		.asciiz	"The sum is: "

.text
main:
        # PRINT LAST NAME AND FOOTHILL ID
        
        la $a0, my_name   # load the addr of my_name into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        la $a0, my_fhID   # load the addr of my_fhID into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        # INTERACT WITH USER FOR INPUT(VALUE OF TOP)
        
        li $v0, 4      # Perform the print_string
	la $a0, prompt # using the prompt
	syscall
                       # Use read_int to read in
	li $v0, 5      # a number into $v0
	syscall
	move $t0, $v0  # Copy it away safely into $t0
	
	#START THE CALCULATION
	
	li $t1, 1             # counter Start at 1
        add $t2, $zero, $zero # Initialize
	
top_of_loop: bgt $t1, $t0, end_of_loop  # Break out if $t0 exceeds loop ub

	add $t2, $t2, $t1     # add the odd to sum
	add $t1, $t1, 2       # $t1 = $t1 + 2
	b top_of_loop         # and loop back

end_of_loop:

	li $v0, 4      	      # Perform the print_string
	la $a0, result        # using the result 
	syscall
	
	move $a0, $t2         # print sum result
	li $v0, 1	      # Prints_int
	syscall
	
	li $v0, 10  # exit syscall
	syscall

