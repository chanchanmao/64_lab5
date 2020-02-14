# conversion.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
	addiu $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)

	move $s2, $a0 # x
	move $s3, $a1 # y

	li $s4, 0 # z
	li $t0, 0 # counter
	li $t1, 5 # compare
	j loop
	
loop:
	beq $t0, $t1, return

	# loop body
	addi $t0, $t0, 1 # increment counter
	
	sll $t2, $s2, 1 # 2*x
	add $s4, $s4, $t2 # z - 2*x
	sub $s4, $s4, $s3 # z - 2*x - y

	jal if

	j loop

return:
	move $v0, $s4
	lw $ra, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addiu $sp, $sp, 12

	jr $ra

if:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	li $t3, 3 # compare
	blt $s2, $t3, end_if
	addi $s3, $s3, -1 # y -= 1

	sw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

end_if:
	addi $s2, $s2, 1 # x += 1
	j loop

main:
	# TODO: Write your main function code here
	li $a0, 5 # a
	li $a1, 7 # b
	jal conv

	# print
	move $a0, $v0 # c
	li $v0, 1
	syscall

exit:
	li $v0, 10
	syscall
