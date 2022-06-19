# CS10 Lab 3
# Program to demonstrate basic Arithmetic, Logical Operations, Making Decisions in MIPS.
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab3.asm
# Date:  10/11/20
# Registers Used:
# $a0 : holds address of my_name, my_fhID, my_sumId, my_sumName, ep1_sum
# ep2_sub, ep3_mult, ep4_adj.
# $s0 : store myId
# $s1 : store nLet
# $t1 : hold addition result
# $t2 : hold subtract result
# $t3 : hold multi result
# $t4 : hold divide result
# $t5 : hold result which checks even/odd
# $t0 : hold modified $t1 if odd
# $v0 : holds addr sycalls

.data 
myId:	        .word 34 #sum of the numbers of my student ID.
nLet: 	        .word 4 #number of letters inmy last name.

my_name:	.asciiz "My family name is Qiao\n"
my_fhID:	.asciiz "My Student ID is 20383477\n"
my_sumId:	.asciiz "The value of myId is 34\n"
my_sumName:	.asciiz "The number of characters in my last name is 4\n"

ep1_sum:	.asciiz "\nnLet + myID = "
ep2_sub:	.asciiz "\nnLet - myID = "
ep3_mult:	.asciiz "\nnLet * 4 = "
ep4_adj:	.asciiz "\neven adjust(nLet + myID) / 2 = "



.text
main:
        # Preparation
        
	lw $s0, myId #store word myId into $s0.
	lw $s1, nLet #store word myId into $s1.
	
        la $a0, my_name   # load the addr of my_name into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        la $a0, my_fhID # load the addr of my_fhID into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        la $a0, my_sumId # load the addr of my_sumId into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        la $a0, my_sumName # load the addr of my_sumName into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        # Computation
        
        add $t1, $s1, $s0	#do $t1 = nLet + myId = 38
	sub $t2, $s1, $s0	#do $t2 = nLet - myId = -30
	sll $t3, $s1, 2         #Shift left logical 2 positions t3 = nLet * 4 = 16
	
	# Even adjust
	andi $t5, $t1, 1        # set $t5 to 1 if odd, 0 if even
        bne $t5, 1, isEven      # jump to branch isEven if $t5 is not 1
        
        #is odd
        sub $t0, $t1, 1         # If the original sum $t1 is odd subtract 1
	srl $t4, $t0, 1		#t1 / 2 = t4
	j printResult
	
        li $v0, 10              # 10 is the exit syscall.
        syscall                 # do the syscall
        
isEven:
        srl $t4, $t1 1		#t1 / 2 = t4
        j printResult
	
printResult:

	# Print out Result
	#1
	la $a0, ep1_sum   # load the addr of ep1_sum into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        move $a0, $t1     # print addition result
        li $v0, 1         # 1 is the print_int syscall.
        syscall           # do the syscall.
        
        #2
        la $a0, ep2_sub   # load the addr of ep2_sub into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
    
        move $a0, $t2     # print subtraction result
        li $v0, 1         # 1 is the print_int syscall.
        syscall           # do the syscall.
        
        #3
        la $a0, ep3_mult  # load the addr of ep3_mult into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        move $a0, $t3     # print addition result
        li $v0, 1         # 1 is the print_int syscall.
        syscall           # do the syscall.
        
        #4
        la $a0, ep4_adj   # load the addr of ep4_adj into $a0.
        li $v0, 4         # 4 is the print_string syscall.
        syscall           # do the syscall.
        
        move $a0, $t4     # print addition result
        li $v0, 1         # 1 is the print_int syscall.
        syscall           # do the syscall.
        
	

