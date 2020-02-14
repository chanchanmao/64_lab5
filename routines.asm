# routines.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
routineB:
    sll $s1, $s1, 1 # 2*x

    sll $t0, $s2, 1 # 2*y
    add $s3, $t0, $s2 # 2*y + y = 3*y

    sub $s3, $s3, 5 # (r-5), r = 3y
    sll $s3, $s3, 2 # (r-5)*4

    add $s1, $s1, $s3 # 2*x + routineB(3*y)

    addi $s0, $s1, -1 # routineB(s1-1)

    addi $s0, $s0, -5 # (r-5), r = s0
    sll $s0, $s0, 2 # (5-r)*4

    move $v0, $s0 # return value

    j exit

routineA:
    move $s1, $a0 # x
    move $s2, $a1 # y

    j routineB

main:
    li $a0, 5 # a
    li $a1, 7 # b
    j routineA

exit:
    # print
    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
