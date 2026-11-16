; practice doing arithmetic in asm
; Tom Merrill
; 2/5/25

; *******************************************************************

; data declarations
section .data

; ----
; Define constants

SUCCESS equ 0
SYS_exit equ 60

; ----
; Define Data

bNum1  db  1
bNum2  db  2
bNum3  db  3
bNum4  db  4
wNum1  dw  600
wNum2  dw  750

bAns1  db  0
bAns2  db  0
bAns3  db  0
bAns6  db  0
bAns7  db  0
bAns8  db  0
wAns11 dw  0
wAns12 dw  0
wAns13 dw  0
bAns16 db  0
bAns17 db  0
bAns18 db  0
bRem18 db  0

; *******************************************************************

; code
section .text
global _start
_start:

; zero out rax and rbx registers
mov rax, 0
mov rbx, 0

; bAns1 = bNum1 + bNum2
mov al, byte [bNum1]
add al, byte [bNum2]
mov byte [bAns1], al

; bAns2 = bNum1 + bNum3
mov al, byte [bNum1]
add al, byte [bNum3]
mov byte [bAns2], al

; bAns3 = bNum3 + bNum4
mov al, byte[bNum3]
add al, byte [bNum4]
mov byte [bAns3], al

; bAns6 = bNum1 - bNum2
mov al, byte [bNum1]
sub al, byte [bNum2]
mov byte [bAns6], al

; bAns7 = bNum1 - bNum3
mov al, byte [bNum1]
sub al, byte [bNum3]
mov byte [bAns7], al

; bAns8 = bNum2 - bNum4
mov al, byte [bNum2]
sub al, byte [bNum4]
mov byte [bAns8], al

; wAns11 = bNum1 * bNum3
mov ax, 0
mov al, byte [bNum1]
cbw
movzx bx, byte [bNum3]
mul bx
mov word [wAns11], ax

; wAns12 = bNum2 * bNum2
mov ax, 0
mov al, byte [bNum2]
cbw
mul ax
mov word [wAns12], ax

; wAns13 = bNum2 * bNum4
mov ax, 0
mov al, byte [bNum2]
cbw
movzx bx, byte [bNum4]
mul bx
mov word [wAns13], ax

; bAns16 = bNum1 / bNum2
mov ax, 0
mov al, byte [bNum1]
div byte [bNum2]
mov byte [bAns16], al

; bAns17 = bNum3 / bNum4
mov ax, 0
mov al, byte [bNum3]
div byte [bNum4]
mov byte [bAns17], al

; bAns18 = wNum1 / bNum4
mov ax, 0
mov al, byte [wNum1]
div byte [bNum4]
mov byte [bAns18], al
mov byte [bRem18], ah

; ----
; Done, terminate program.

mov rax, SYS_exit
mov rdi, SUCCESS
syscall 
  
