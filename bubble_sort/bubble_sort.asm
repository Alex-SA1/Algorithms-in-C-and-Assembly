bits 32 ; indicating to the processor that we are working with 32-bit instructions

; making the function tag avaible outside of the current file
global _bubble_sort

segment code use32 class=code:
    _bubble_sort:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; saving the value of all registers
        pushad

        ; stack representation
        ; esp ->      | all registers  |
        ;                   . . .
        ; ebp ->      |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |length          | <- first parameter of the function 
        ; ebp + 12    |array           | <- second parameter of the function
        ;             | C program data | 

        mov ecx, [ebp + 8]
        mov esi, [ebp + 12]

        ; if the length of the array is equal with zero, we jump to the end of the function because there are no elements to sort
        jecxz .end_program

        ; if the length of the array is equal with one, we jump to the end of the function because the arrays is sorted
        cmp ecx, 1
        je .end_program

    .repeat:
        ; we assume that the arrays is sorted
        mov bl, 1

        push ecx ; saving the length of the array

        dec ecx ; we have to iterate over just (length - 1) elements because every element is compared with the one after
        ; iterator
        mov edi, 0
    .compare:
        mov eax, [esi + edi]
        mov edx, [esi + edi + 4]

        cmp eax, edx
        jle .continue_compare ; if eax <= edx the elements are positioned correctly

        ; eax > edx

        mov [esi + edi], edx
        mov [esi + edi + 4], eax
        mov bl, 0 ; we had to swap two elements, that means the array is not sorted

    .continue_compare:
        add edi, 4
        loop .compare

        ; restoring the length of the array
        pop ecx

        cmp bl, 0
        je .repeat ; if the array is still not sorted, we have to continue the process of comparing


    .end_program:
        ; restoring values of the registers
        popad

        ; restoration of the stack frame
        mov esp, ebp
        pop ebp

        ; going to the return address
        ret

    
    


