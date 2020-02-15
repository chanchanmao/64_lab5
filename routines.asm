# routines.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
routineB:
    sub $t0, $a1, 5
    sll $t0, $t0, 2

    move $v0, $t0
    jr $ra

routineA:
    addiu $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    sw $a1, 0($sp)

    sll $s1, $a0, 1 # 2*x

    sll $t0, $a1, 1 # 2*y
    add $a1, $a1, $t0, # 2*y + y = 3*y

    jal routineB # routineB(3*y)

    lw $a1, 0($sp)
    add $s1, $s1, $v0 # s1 = 2*x + routineB(3*y)
    addi $a1, $s1, -1 # s1 - 1

    addiu $sp, $sp, -4
    sw $v0, 0($sp)

    jal routineB # routineB(s1-1)

    lw $ra, 12($sp)
    addiu $sp, $sp, 16

    jr $ra

main:
    li $a0, 5 # a
    li $a1, 7 # b
    jal routineA

    # print
    move $a0, $v0
    li $v0, 1
    syscall

exit:

    li $v0, 10
    syscall