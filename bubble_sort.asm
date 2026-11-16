; simple implementation of bubble sort

;********************************************************************
;Define constants
section .data

EXIT_SUCCESS  equ 0
SYS_exit      equ 60
FALSE         equ 0
TRUE          equ 255

;----
; define data
section .data
   lst      dd  9, 8, 7, 6
   len      dd  4
   swapped  dd  FALSE

;********************************************************************
section .text
global _start
_start:
  xor rcx, rcx                          ; zero out rcx
  mov ecx,  dword[len]                  ; set up outer loop counter
  sub rcx, 1                            ; sub one to get zero indexed

outerLoop: 
  mov rbx,  0                           ; set up inner loop counter
  mov dword [swapped], FALSE            ; reset swapped to FALSE

innerLoop:
  xor rax, rax                          ; zero out rax to load value from list
  xor rdx, rdx                          ; zero out rdx to load value from list
  mov eax, dword [lst+rbx*4]            ; load element from list - first of pair
  mov edx, dword [lst+(rbx+1)*4]        ; load element from list - second of pair
  cmp rax, rdx                          ; check if the first element is greater than the second
  jg  orderCheck                        ; if it is, jump to orderCheck to process the swap
  inc rbx                               ; increment innerLoop counter
  cmp rbx, rcx                          ; if innerLoop count is equal to outLoop counter
  je  swapCheck                         ; jmp out of innerLoop and do swap check
  jmp innerLoop	                        ; othewise, start innerLoop again

swapCheck:
  cmp dword[swapped], FALSE
  je  End
  loop outerLoop
  jmp End

orderCheck:
  mov dword [lst+(rbx+1)*4], eax
  mov dword [lst+rbx*4], edx
  mov dword [swapped], TRUE 
  inc rbx
  cmp rbx, rcx
  je  swapCheck
  jmp innerLoop	

End:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
