#  Lab 7 CS10 w8zerodivide.asm 
#  Example program which causes an exception
#  Use your lab8 exception handler
#  Registers Used:
#  $a0 : holds address of my_name, my_fhID, result.
#  $t1 : hold value of numerator
#  $t0 : hold value of denominator

        .data 

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Foothill Student ID is 20383477\n"
	.text
	.globl main
main:	
	# PRINT LAST NAME AND FOOTHILL ID
        
        la $a0, my_name       # load the addr of my_name into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
        la $a0, my_fhID       # load the addr of my_fhID into $a0.
        li $v0, 4             # 4 is the print_string syscall.
        syscall               # do the syscall.
        
	li $t1, 300
	li $t0, 0
	div $a0, $t1, $t0	# Do $a0 = $t1 / $t0

	li $v0, 1		    # Print result as an integer
	syscall

	li $v0, 10		    # and exit
	syscall
