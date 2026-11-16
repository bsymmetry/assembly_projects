; Unsigned Arithmetic Practice
; Tom Merrill
; 2/7/25
; *******************************************************************

; data declaration
section .data

; ----
; define constant

SUCCESS equ 0
SYS_exit equ 60

; ---
; define data

wNum1 dw 50000
wNum2 dw 25000
wNum3 dw 30000
wNum4 dw 15000
dNum1 dd 4000000
wAns1 dw 0
wAns2 dw 0
wAns3 dw 0
wAns6 dw 0
wAns7 dw 0
wAns8 dw 0
dAns11 dd 0
dAns12 dd 0
dAns13 dd 0
wAns16 dw 0
wAns17 dw 0
wAns18 dw 0
wRem18 dw 0

; *******************************************************************

; code
section .text
global _start
_start:

; zero out rax and rbx registers
xor rax, rax
xor rbx, rbx

; wAns1 = wNum1 + wNum2
mov eax, 0
mov ax, word [wNum1]
add ax, word [wNum2]
mov word [wAns1], ax

; wAns2 = wNum1 + wNum3
mov eax, 0
mov ax, word [wNum1]
add ax, word [wNum2]
mov word [wAns2], ax

; wAns3 = wNum3 + wNum4
mov eax, 0
mov ax, word [wNum3]
add ax, word [wNum4]
mov word [wAns3], ax

; wAns6 = wNum1 - wNum2
mov eax, 0
mov ax, word [wNum1]
sub ax, word [wNum2]
mov word [wAns6], ax

; wAns7 = wNum1 - wNum3
mov eax, 0
mov ax, word [wNum1]
sub ax, word [wNum3]
mov word [wAns7], ax

; wAns8 = wNum2 - wNum4
mov eax, 0
mov ax, word [wNum2]
sub ax, word [wNum4]
mov word [wAns8], ax

; dAns11 = wNum1 * wNum3
mov ax, word [wNum1]
cwd
movzx ebx, word [wNum3]
mul ebx
mov dword [dAns11], ebx

; dAns12 = wNum2 * wNum2
mov ax, word [wNum2]
cwd
movzx ebx, word [wNum2]
mul ebx
mov dword [dAns12], ebx

; dAns13 = wNum2 * wNum4
mov ax, word [wNum2]
cwd
mul word [wNum4]
mov dword [dAns13], ebx

; wAns16 = wNum1 / wNum2
mov eax, 0
mov ax, word [wNum1]
div word [wNum2]
mov word [wAns16], ax

; wAns17 = wNum3 / wNum4
mov eax, 0
mov ax, word [wNum3]
div word [wNum4]
mov word [wAns17], ax

; wAns18 = dNum1 / wNum4
; wRem18 = dNum1 % wNum4
mov eax, 0
mov eax, dword [dNum1]
div word [wNum4]
mov word [wAns18], ax
mov word [wRem18], dx

; exit
mov rax, SUCCESS
mov rdi, SYS_exit
syscall

