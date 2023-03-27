/*
-------------------------------------------------------
lan04_t01.s
-------------------------------------------------------
Author:  Aleksander Sienkiewicz
ID:      210222490
Email:   sien2490@mylaurier.ca
Date:    2023-02-18
-------------------------------------------------------
*/
// Constants            
.equ UART_BASE, 0xff201000
.equ SIZE, 80
.equ VALID, 0x8000
.equ ENTER, 0x0a
.org 0x1000//start memory location 

//.txt
.global _start
_start:
//read str from uart
LDR R1,=UART_BASE
LDR R4, =READ_STRING
ADD R5, R4, #SIZE//store address of buffer end

LOOP:
LDRB R0, [R1]

CMP R0, #ENTER
STRB R0, [R1]    

BEQ _stop //stop when enter is hit
STRB R0, [R4]
ADD R4,R4,#1//move to next byte
BEQ _stop
B	LOOP

_stop:
B	_stop

.data
//make storage for string available
READ_STRING:
.space	SIZE

.end
