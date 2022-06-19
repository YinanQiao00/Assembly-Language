# Unit 3 Example CS10 
# Program Name:  w3labelex.asm 
# Description: Program to demonstrate a label in MIPS.
# Labels are terminated by a colon character.
# Registers used:
# t0 - used to hold the data operand num1
# t1 - used to hold the data operand num2
# v0 - syscall parameter 
# A label in MIPS is a string used to name a memory location.
# A label may refer to the location of a data value or an instruction.
# Think of a label as representing an address.
# View the Labels window to see the label address.

    .data
num1: .word 2
num2: .word 3

    .text
main:                # start execution at main
   lw $t0, num1      # $t0 <- Mem[num1] 
   lw $t1, num2      # $t1 <- Mem[num2]
   
exit: 
   li $v0, 10        # 10 is the exit syscall
   syscall           # do the syscall
   

