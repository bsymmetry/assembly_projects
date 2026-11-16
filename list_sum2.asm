; Simple example to get the sum and average for a list of numbers
; *******************************************************************
; Data declarations
section .data
; ----
; Define constants

EXIT_SUCCESS equ 0         ; successful operatoin
SYS_exit     equ 60        ; call code for termination

; ----
; Define Data

section .data
    lst      dd  1002, 1004, 1006, 1008, 10010
    len      dd  5
    sum      dd  0
    min      dd  0
    max      dd  0
    ave      dd  0

; *******************************************************************
section .text
global _start
_start:

; ----
; Summation loop

    mov  ecx, dword [len]        ; get length value
    mov  rsi, 0                  ; index=0

sumLoop:
    mov  eax, dword [lst+rsi*4]  ; get lst[rsi]
    add  dword [sum], eax        ; update sum value
    inc  rsi                     ; next item in lst
    loop sumLoop

; ----
; calculate min and max

   mov eax, dword [sum]          ; load sum as the starting point
   mov dword[min], eax           ; for min and
;  mov dword[max], eax           ; max

   mov ecx, dword [len]          ; reload len for loop counter
   mov rsi, 0                    ; reset index to 0
   
statsLoop:
   mov eax, dword [lst+rsi*4]    ; load first element of list
   cmp eax, dword [min]
   jae notNewMin                 ; if eax >= list[rsi], then jump to notNewMin
   mov dword [min], eax

notNewMin:
   cmp eax, dword [max]
   jbe notNewMax                 ; if eax <= list[rsi], then jum to notNewMax
   mov dword [max], eax

notNewMax:
   inc rsi                       ; increment index, decrement ecx and jump to beginning
   loop statsLoop

; ----
; calculate averages 

   mov eax, dword [sum]
   mov edx, 0
   div dword [len]
   mov dword [ave], eax

; ----
; Done, terminate

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with sucess
    syscall
