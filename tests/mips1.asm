start:
nop
nop

addi $t0, $zero, 2
addi $t1, $zero, 1

beq $t0, $t1, start

main:
addi $t0, $zero, 1
addi $t1, $zero, 1

beq $t0, $t1, main