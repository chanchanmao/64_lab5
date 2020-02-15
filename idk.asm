.data
	# TODO: Write your initializations here
	myArr: .word 1 2 3 4 5 6 7 8 9 10
	myArrLen: .word 10
	newline: .asciiz "\n"
	content: .asciiz "The contents of the array are:\n"

.text
printA:
    la $t0, myArr
    li $v0, 1
    li $t1, 0

for:
    bge $t1, $a1, end
    li $v0, 1
    lw $a0, 0($t0)
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addiu $t0, $t0, 4
    addiu $t1, $t1, 1
    j for

end:
    jr $ra

main:
    la $s1, myArrLen
    lw $a1, 0($s1)

    la $a0, content
    li $v0, 4
    syscall

    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    jal printA

exit:
    li $v0, 10
    syscall