; Simple example program to compute the square of sums from 1 to n
; *******************************************************************
; Data Declarations

section .data

; ----
; Definte constants

SUCCESS       equ   0                ; Successful operation
SYS_exit      equ   60               ; call code for terminate

; Define Data.

n             dd    10
sum           dq    0
squareOfSums  dq    0

; *******************************************************************

section .text

global _start
_start:

; ----
; Compute sum of squares from 1 to n (inclusive).
; Approach:
; for (i=1; i<=n; i++)
;    sumOfSquares += i^2;

	mov   rbx, 1                    ; i
	mov   ecx, dword [n]
    sumLoop:
	mov   rax, rbx                  ; get i
;mul   rax                       ; i^2
	add   qword [sum], rax
	inc   rbx
	loop  sumLoop

        mov rax, qword [sum]
        mul qword [sum]
        mov qword [squareOfSums], rax
        
; ----
; Done, terminate program.

last:
	mov   rax, SYS_exit               ; call code for exit
        mov   rdi, SUCCESS                ; exit with success
	syscall
	
