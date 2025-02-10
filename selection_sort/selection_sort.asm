bits 32 ; indicating to the processor that we are working with 32-bits instructions

; making the tag available outside of the current file
global _selection_sort

segment code use32 class=code:
    _selection_sort:
        ; creating a stack frame for the .asm program
        push ebp
        mov ebp, esp

        ; saving the values of all registers to restore at the end of the program
        pushad

        ; stack representation
        ; esp ->      | all registers  |
        ;                   . . .
        ; ebp ->      |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |length          | <- first parameter of the function 
        ; ebp + 12    |array           | <- second parameter of the function
        ;             | C program data | 

        mov ecx, [ebp + 8] ; the length of the array
        mov esi, [ebp + 12] ; the start address of the array

        ; the array contains values represented on 4 bytes (int) so we can manipulate them with dword representation type

        jecxz .end_program ; if the length of the array is equal with zero, we jump straight to the end of the program

        dec ecx ; we have to verify just the length - 1 elements from the array (the last one is insignificant because he has no elements after it in the array)
        jecxz .end_program

        mov edi, 0 ; iterator for the array

    .outer_loop:
        mov eax, [esi + edi] ; current element from the array
        mov edx, edi ; saving the index of the current element

        push dword ecx ; saving the value of ecx so that we can use this register for the second loop and restore it after that
        push dword edi ; saving also the value of the iterator

        add edi, 4 ; starting the iteration from the next element

    .inner_loop:
        ; in this loop we will search for an element smaller than the current element
        mov ebx, [esi + edi]

        cmp eax, ebx
        jle .continue_inner_loop ; eax <= ebx

        ; eax > ebx, we find a smaller element
        mov eax, ebx ; updating the value to be compared
        mov edx, edi ; updating the index of the value to be compared

    .continue_inner_loop:
        add edi, 4
        loop .inner_loop

        ; restoring the saved values
        pop edi 
        pop ecx

        ; swapping the current element with the smallest one from the right part of the array
        mov eax, [esi + edi] ; the current element
        mov ebx, [esi + edx] ; the smallest element from the right part

        mov [esi + edi], ebx
        mov [esi + edx], eax

    .continue_outer_loop:    
        add edi, 4
        loop .outer_loop

    .end_program:
        ; restoring the value of the registers
        popad

        ; restoration of the stack frame
        mov esp, ebp
        pop ebp

        ; going to the return address
        ret

        