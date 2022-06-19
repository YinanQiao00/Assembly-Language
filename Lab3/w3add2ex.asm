# Unit 3 Example CS10 
# Program Name:  w3add2ex.asm 
# Description: Program to demonstrate computing the sum 
#              of 2 and 3 in MIPS
# Registers used:
# t0 - used to hold the result
# t1 - used to hold the constant 2
# v0 - syscall parameter 

    .data
add2_msg:   .asciiz "adding 2 small integer data values\n"
res_msg:    .asciiz "check for result value in $t0 register\n"

    .text
main:                # MARS start execution at main
   la $a0, add2_msg  # load the addr of add2_msg into $a0
   li $v0, 4         # 4 is the print_string syscall
   syscall           # do the syscall
   li $t1, 2 	     # load 2 into $t1
   add $t0, $t1, 3   # put sum of $t1 and 3 into $t0
   la $a0, res_msg   # load the addr of res_msg into $a0
   li $v0, 4         # 4 is the print_string syscall
   syscall           # do the syscall
   li $v0, 10        # 10 is the exit syscall
   syscall           # do the syscall
   

