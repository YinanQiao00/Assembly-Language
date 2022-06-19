# Example CS10 Lab 8 Hands-on Solution
# Program Name:  a8_Solution.asm 
# Topic: Pipelining in MIPS
# Description: Snippet example of software optimization
#              using nops to ensure correct execution
#              despite data hazards presented in the
#              instruction stream.          
# Registers used:
# i1: writer $3, readers $2, $3
# i2: writer $4, reader $3
# i3: writer $7, readers $6, $2
# i4: writer $6, readers $4, $3
# $v0 - syscall parameter and return value
# $a0 - syscall parameter
# Date: 06/16/2020

	.data
int_array:  .word      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            .word      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.text
main:
   la $3, int_array  # load addr of first word in my_array into $3
   li $6, 1          # sub Rd, Rs, Rt = RF[Rd] = RF[Rs] - RF[Rt]
                     # init reg Rs (i3 below) 


   add $3, $2, $3    # i1
	nop               # The value of register $3 does not reach the 
	nop               # register file until the WB # stage of the add 
	                  # instruction (see cycle 5 below).  Yet the lw 
	                  # instruction needs this value in its ID stage
	                  # when it reads register $3. In order to delay
	                  # the ID stage of the lw until cycle 5, 2 nops
	                  # need to be inserted.
	
	
	lw $4, 100($3)    # i2
	sub $7, $6, $2    # i3
	nop               # The new value of register $4 does not reach
	                  # the register file until the WB stage of the lw
	                  # instruction.  If we did not insert this nop, 
	                  # the ID stage of the xor would coincide with 
	                  # the MEM stage of the lw.
	xor $6, $4, $3	   # i4
	
	                  ## exit program
   li $v0, 10        # terminate program run and 
   syscall           # return control to system
	
	
#+-------------------------------------------------------------------------------+
#|  Original          |                       CPU Cycles                         |
#+--------------------+----+----+------------------------------------------------+
#|                    | 1  | 2  | 3  |  4  | 5  | 6  |  7  |  8  |  9  | 10 | 11 |
#+--------------------+----+----+----+-----+----+----+-----+-----+-----+----+----+
#|i1 add $3, $2, $3   | IF | ID | EX | MEM | WB |    |     |     |     |    |    |
#|i2 lw $4, 100($3)   |    | IF | ID | ID  | ID | EX | MEM | WB  |     |    |    |
#|i3 sub $7, $6, $2   |    |    | IF | IF  | IF | ID | EX  | MEM | WB  |    |    |
#|i4 xor $6, $4, $3   |    |    |    |     |    | IF | ID  | EX  | MEM | EX | WB | 
#+---------+---------------------------------------------------------------------+

#+-------------------------------------------------------------------------------+
#|  Solution          |                       CPU Cycles                         |
#+--------------------+----+----+------------------------------------------------+
#|                    | 1  | 2  | 3  |  4  | 5  | 6  |  7  |  8  |  9  | 10 | 11 |
#+--------------------+----+----+----+-----+----+----+-----+-----+-----+----+----+
#|i1 add $3, $2, $3   | IF | ID | EX | MEM | WB |    |     |     |     |    |    |
#|i2 lw $4, 100($3)   |    | nop| nop| IF  | ID | EX | MEM | WB  |     |    |    |
#|i3 sub $7, $6, $2   |    |    |    |     | IF | ID | EX  | MEM | WB  |    |    |
#|i4 xor $6, $4, $3   |    |    |    |     |    | nop| IF  | ID  | EX  | MEM| WB | 
#+---------+---------------------------------------------------------------------+





