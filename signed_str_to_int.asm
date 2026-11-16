; Simple example program to convert an ASCII string into an integer

; *******************************************************************
; Data declarations

section .data

; ----
; Define constants

NULL         equ 0
EXIT_SUCCESS equ 0
EXIT_FAILURE equ -1
SYS_exit     equ 60

; ----
; Deinf data

strNum       db   "1498" 
negative     dd   0
negOne       dd  -1 
ERR_BADCHR   db   "Invalid Character"

section .bss

intNum       resd 10

; *******************************************************************

section .text
global signed_str_to_int
signed_str_to_int:

; convert an ASCII string into an integer

; ----
; looping through string, error checking, and converting to int

  xor rdx, rdx                     ; create integer in rdx so zero out rdx
  mov rbx, 0                       ; index=0
  mov rcx, 0                       ; charCount = 0
  mov r8 , 10                      ; loaded to multiply interim int by 10

processStrLoop:
  xor rax, rax                     ; zero out rax to use for each char
  mov al, byte [strNum+rbx]        ; get first char of string
  cmp al, "0"                      ; compare char with ascii 48
  jb notADigit                     ; if below this number, then char isn't a digit
  cmp al, "9"                      ; compare char with ascii 57
  ja notADigit                     ; if above this number, then char isn't a digit
  inc rcx
  inc rbx
  jmp strToInt

notADigit:
  cmp al, "-"                      ; if first char is "-" then set negative to 1
  jne plusCheck                    ; jump if not equal to negative sign
  cmp rbx, 0                       ; if index is not zero, then this is an invalid char
  jne error
  mov dword [negative], 1          ; if there is a negative sign, set negative to 1
  inc rbx                          ; increment index
  jmp processStrLoop

plusCheck:
  cmp al, "+"
  jne nullCheck                    ; if char is not a digit, or -/+, then need to check null
  cmp rbx, 0                       ; if index is not zero, then this is an invalid char
  jne error
  inc rbx                          ; increment index
  jmp processStrLoop

nullCheck:
  cmp al, NULL
  jne error                        ; if char is not a digit, -/+, or null, then it is invalid
  jmp negCheck

error:
  ; print error message
  mov rax, 1                       ; sys_write
  mov rdi, 1                       ; stdout
  mov rsi, ERR_BADCHAR             ; pointer to error message
  mov rdx, 18                      ; length of error message
  syscall

  ; exit with failure
  mov rax, SYS_exit
  mov rdi, EXIT_FAILURE
  syscall

strToInt:
  sub al, '0'                      ; subtract 0 char to get to int
  imul rdx, r8                      ; increase digit by 10 since we are interating left to right
  add edx, eax                     ; add most recent digit to int
  jmp processStrLoop	

negCheck:
  cmp dword [negative], 1          ; check if the integer should be negative
  jne loadStr
  imul rdx, -1                     ; if int should be negative, then mul by -1
loadStr:
  mov dword [intNum], edx          ; load int to memory

; ----
; Done, terminate

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
