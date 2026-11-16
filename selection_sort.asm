; function to perform selection sort on an array of ints
; ---------------------------------------------------------

section .data
; Define standard constants

; ----
; define variables

; ---------------------------------------------------------

section .text
global selection_sort

; arguments: 1) addr of array of ints, 2)len of array 
; return - void, sorts in place

selection_sort:

  ; I need to create an outer loop that iterates over all items in array
  ; then save the smallest item and an index
  ; then an inner loop,  that iterates over all items from index to end of array
  ; then check if the current item is smaller than the smallest item saved
  ; Note - don't validate inputs
  ; how do you know what the min/max valid memory is?
  ; how do you know what the min/max integer is?
  ; since I don't convert from string to int here, I have to do the valid check
  ; where I do that. 

prologue:
  push rbx
  push r12
  push r13
  push r14
  
lenCheck:
  cmp rsi, 1    ; check if the len of array is 1 or less
  jle end       ; if it is return without trying to sort

setup:
  mov rbx, 0    ; set i = 0 for outer for loop
  mov r12, 0    ; clear j to zero
  xor r10, r10  ; clear r10 to store small
  xor r11, r11  ; clear r11 to store index

outerLoop:
  mov r10, qword [rdi+rbx*8]  ; small = arr[i]
  mov r11, rbx                ; index = i

innerLoop:
  mov r12, rbx                ; j = i
  mov r13, qword[rdi+r12*8]   ; arr(j)
  cmp r10, r13                ; arr(j) < small
  jge increment 
  mov r10, r13                ; small = arr(j)
  mov r11, r12                ; index = j
increment:
  inc r12
  cmp r12, rsi                ; if j >= len, end innerLoop; go to outerLoop
  jl innerLoop
  mov r14, qword[rdi+rbx*8] 
  mov qword[rdi+r11*8], r14   ; arr[index] = arr[i]
  mov qword[rdi+rbx*8], r10   ; arr[i] = small
  inc rbx
  cmp rbx, rsi                ; i < len
  jl outerLoop

end:
  pop r14
  pop r13
  pop r12
  pop rbx
  ret
  
