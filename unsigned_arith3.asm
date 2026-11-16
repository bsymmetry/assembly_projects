; practice doing arithmetic in asm
; Tom Merrill
; 3/1/25

; *******************************************************************

; data declarations
section .data

; ----
; Define constants

SUCCESS equ 0
SYS_exit equ 60

; ----
; Define Data

dNum1  dd 400000
dNum2  dd 300000
dNum3  dd 200000
dNum4  dd 100000
qNum1  dq 10000000
dAns1  dd 0
dAns2  dd 0
dAns3  dd 0
dAns6  dd 0
dAns7  dd 0
dAns8  dd 0
qAns11 dq 0
qAns12 dq 0
qAns13 dq 0
dAns16 dd 0
dAns17 dd 0
dAns18 dd 0
dRem18 dd 0

; *******************************************************************

; code
section .text
global _start
_start:

; zero out rax and rbx registers
xor rax, rax
xor rbx, rbx

; dAns1 = dNum1 + dNum2
mov rax, 0
mov eax, dword [dNum1]
add eax, dword [dNum2]
mov dword [dAns1], eax

; dAns2 = dNum1 + dNum3
mov rax, 0
mov eax, dword [dNum1]
add eax, dword [dNum3]
mov dword [dAns2], eax

; dAns3 = dNum3 + dNum4
mov rax, 0
mov eax, dword [dNum3]
add eax, dword [dNum4]
mov dword [dAns3], eax

; dAns6 = dNum1 - dNum2
mov rax, 0
mov eax, dword [dNum1]
sub eax, dword [dNum2]
mov dword [dAns6], eax

; dAns7 = dNum1 - dNum3
mov rax, 0
mov eax, dword [dNum1]
sub eax, dword [dNum3]
mov dword [dAns7], eax

; dAns8 = dNum2 - dNum4
mov rax, 0
mov eax, dword [dNum2]
sub eax, dword [dNum4]
mov dword [dAns8], eax

; qAns11 = dNum1 * dNum3
mov eax, dword [dNum3]
cdq
mov rbx, rax
mov eax, dword [dNum1]
cdq
mul rbx
mov qword [qAns11], rax

; qAns12 = dNum2 * dNum2
mov eax, dword [dNum2]
cdq
mov rbx, rax
mov eax, dword [dNum2]
cdq
mul rbx
mov qword [qAns12], rax

; qAns13 = dNum2 * dNum4
mov eax, dword [dNum4]
cdq
mov rbx, rax
mov eax, dword [dNum2]
cdq
mul rbx
mov qword [qAns13], rax

; dAns16 = dNum1 / dNum2
mov rax, 0
mov eax, dword [dNum1]
div dword [dNum2]
mov dword [dAns16], eax

; dAns17 = dNum3 / dNum4
mov rax, 0
mov eax, dword [dNum3]
div dword [dNum4]
mov dword [dAns17], eax

; dAns18 = qNum1 / dNum4
mov rax, 0
mov rax, qword [qNum1]
div dword [dNum4]
mov dword [dAns18], eax
mov dword [dRem18], edx

; exit
mov rax, SUCCESS
mov rdi, SYS_exit
syscall
