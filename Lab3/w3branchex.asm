# Unit 3 Example CS10 
# Program Name:  w3branchex.asm 
# Description: Program to demonstrate making decisions. 
# Registers used:
# t0 - used to hold the data operand num1
# t1 - used to hold the data operand num2
# v0 - syscall parameter 

    .data
num1:    .word 2
num2:    .word 3
eq_msg:  .asciiz "not equal\n"

    .text
main:                 # start execution at main
   lw $t0, num1       # $t0 <- Mem[num1] 
   lw $t1, num2       # $t1 <- Mem[num2]
   bne $t0, $t1, exit # if the 2 values are not equal branch to exit
   la $a0, eq_msg     # if the 2 values are equal print out eq_msg
   li $v0, 4          # 4 is the print_string syscall
   syscall            # do the syscall
   
exit: 
   li $v0, 10         # 10 is the exit syscall
   syscall            # do the syscall
   

