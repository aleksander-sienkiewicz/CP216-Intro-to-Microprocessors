/*
-------------------------------------------------------
l05_t02.s
A simple list demo program. Traverses all elements of an integer list.
R0: temp storage of value in list
R2: address of start of list
R3: address of end of list
-------------------------------------------------------
Author:  Aleksander Sienkiewicz
ID:      210222490
Email:   sien2490@mylaurier.ca
Date:    2023-03-04
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

MOV R4, #0 //# OF VALUES IN LIST
MOV R5, #0//#BYTES

LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list

//ALGORITHM
SUB R5, R3, R2 //DIF BETWEEN START AND END = total values
MOV R5, R5, LSR #2 // each num made of 4 bytes, therefore total/4 = num bytes

Loop:
LDR    R0, [R2], #4	// Read address with post-increment (R0 = *R2, R2 += 4)

ADD R4, R4, #1//add 1 to register 4

CMP    R3, R2       // Compare current address with end of list
BNE    Loop         // If not at end, continue

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	// End of list address

.end