
	/*
-------------------------------------------------------
lab04_t01.s
-------------------------------------------------------
Author:  Aleksander Sienkiewicz
ID:      210222490
Email:   sien2490@mylaurier.ca
Date:    2023-02-18
-------------------------------------------------------
*/
.equ UART_BASE, 0xff201000 
.equ SIZE, 80
.equ VALID, 0x8000
.equ ENTER, 0x0a
.org 0x1000


.global _start
_start:

LDR R1, =UART_BASE
LDR R4, =READ_STRING
ADD R5, R4, #SIZE

LOOP:
LDRB R0, [R1]//read register
CMP R0, #ENTER//check w/ enter
BEQ _stop//stop when found
STRB R0, [R4]
ADD R4,R4, #1//move to next byte in buffer
CMP R4, R5//end if buffers full
BEQ _stop
B LOOP

_stop:
B 	_stop

.data

READ_STRING:
.space	SIZE//set asside storage

.end 