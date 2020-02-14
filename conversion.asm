# conversion.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	move $a0, $s0 # x
	move $a1, $s1 # y

	li $v0, 0 # z
	li $t0, 0 # i
	li $t1, 5 # compare with this value

	j loop_for

loop_for:
	bgt $t0, $t1, exit # if !(i < 5) = if (i >= 5)
	sll $a0, $a0, 1 # 2 * x
	add $v0, $v0, $a0 # z + 2x
	sub $v0, $v0, 1 # z +2x - y

	jal loop_if

	addi $t0, $t0, -1

loop_if:
	li $t2, 3 # compare with this value
	bge $a0, 3, if
	addi $a0, $a0, 1

if:
	addi $a1, $a1, -1
	jr $ra

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

main:
	# TODO: Write your main function code here
	li $s0, 5 # a
	li $s1, 7 # b

	jal conv

	# print
	li $v0, 1
	move $a0, $v0, # store c in $v0
	syscall

exit:
	li $v0, 10
	syscall
