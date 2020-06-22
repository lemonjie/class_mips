	.data
msgID:  .asciiz "My student ID is {ID}\n"
msgIn:  .asciiz "Please input a positive integer (n):\n"
msgOut: .asciiz "! = "
        .text
        .globl main
main:
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        #print msgID(student ID)
        li $v0, 4
        la $a0, msgID
        syscall

        #print msgIn
        la $a0, msgIn
        syscall

        #get user input to $t1
        la $v0, 5
        syscall
        addi $a0, $v0, 0

        #calculate n!
        jal Loop
        add $t0, $v0, $0

        #print n!=k
        li $v0, 1
        syscall
        li $v0, 4
        la $a0, msgOut
        syscall
        li $v0, 1
        add $a0, $t0, $0
        syscall
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra          	

Loop:   addi $sp $sp -8
        sw $ra, 4($sp)
        sw $a0, 0($sp)
        slti $t0, $a0, 1
        beq $t0, $0, L1
        addi $v0, $0, 1
        addi $sp, $sp, 8
        jr $ra
L1:     addi $a0, $a0, -1
        jal Loop
        lw $a0, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8
        mul $v0, $a0, $v0
        jr $ra
