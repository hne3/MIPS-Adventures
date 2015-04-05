.data
getN:
.asciiz "\Please insert the number of integers in your list.\n"
getList:
.asciiz "\Please enter your sorted list.\n"
getSearchInput:
.asciiz "What value would you like to search for?\n"
confirmation:
.asciiz "Okay, searching.\n"

.text
main:
la $a0, getN # Asks user for number of integers.
li $v0, 4
syscall
li $v0, 5
syscall # Receives number of integers
