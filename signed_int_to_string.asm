; Simple example program to convert an integer to an ASCII string

; *******************************************************************

; integer to string macro with 4 arguments: <intNum>, <negative>, <negOne>, <strNum>

%macro intToStr 4
; Part A - Successive division

  mov eax, dword [%1]          ; get integer
  mov rcx, 0                       ; digitCount = 0
  mov ebx, 10                      ; set for dividing by 10
  cmp eax, 0                       ; if integer is negative set neg to true
  jge divideLoop                   ; and take absolute value
  mov dword [%2], 1
  imul eax, dword [%3] 

%%divideLoop:
  mov edx, 0
  div ebx                          ; divide number by 10

  push rdx                         ; push remainder
  inc  rcx                         ; increment digitCount

  cmp eax, 0                       ; if (result > 0)
  jne divideLoop                   ; goto divideLoop

; ----
; Part B - Convert remainders and stor

  mov rbx, %4                  ; get address of string
  mov rdi, 0                       ; idx = 0
  cmp dword [%2], 0               ; if neg integer then add neg sign to string
  je popLoop
  mov byte [rbx+rdi], "-"
  inc rdi

%%popLoop:
  pop rax                          ; pop intDigit

  add al, "0"                      ; char = int + "0"

  mov byte [rbx+rdi], al           ; string[idx] = char
  inc rdi                          ; increment idx
  loop popLoop                     ; if (digitCount > 0)
                                   ; goto popLoop
  mov byte [rbx+rdi], 0         ; string[idx] = NULL

; *******************************************************************
; Data declarations

section .data

; ----
; Define constants

NULL         equ 0
EXIT_SUCCESS equ 0
SYS_exit     equ 0

; ----
; Deinf data

intNum       dd   0  ;203834  ;-1498
negative     dd   0
negOne       dd  -1 

section .bss

strNum       resb 10

; *******************************************************************

section .text
global _start
_start:

; convert an integer into an ASCII string

; ----
intToStr intNum, negative, negOne, strNum
; ----
; Done, terminate

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
