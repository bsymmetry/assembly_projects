; Simple example program to convert an integer to an ASCII string

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

intNum       dd  1498

section .bss

strNum       resb 10

; *******************************************************************

section .text
global _start
_start:

; convert an integer into an ASCII string

; ----
; Part A - Successive division

  mov eax, dword [intNum]          ; get integer
  mov rcx, 0                       ; digitCount = 0
  mov ebx, 10                      ; set for dividing by 10

divideLoop:
  mov edx, 0
  div ebx                          ; divide number by 10

  push rdx                         ; push remainder
  inc  rcx                         ; increment digitCount

  cmp eax, 0                       ; if (result > 0)
  jne divideLoop                   ; goto divideLoop

; ----
; Part B - Convert remainders and stor

  mov rbx, strNum                  ; get address of string
  mov rdi, 0                       ; idx = 0

popLoop:
  pop rax                          ; pop intDigit

  add al, "0"                      ; char = int + "0"

  mov byte [rbx+rdi], al           ; string[idx] = char
  inc rdi                          ; increment idx
  loop popLoop                     ; if (digitCount > 0)
                                   ; goto popLoop
  mov byte [rbx+rbi], NULL         ; string[idx] = NULL

; ----
; Done, terminate

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
