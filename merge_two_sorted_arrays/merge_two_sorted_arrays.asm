bits 32 ; indicating to the processor that we are working with 32-bit instructions

; making the function tag available outside of the current file
global _merge

segment code use32 class=code:
    _merge:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; saving the values of all registers on the stack
        pushad

        ; stack representation
        ; esp ->      | all registers  |
        ;                   . . .
        ; ebp ->      |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |length_1        | <- first parameter of the function
        ; ebp + 12    |array_1         | <- second parameter of the function
        ; ebp + 16    |length_2        | <- third parameter of the function
        ; ebp + 20    |array_2         | <- fourth parameter of the function
        ; ebp + 24    |merged          | <- fifth parameter of the function
        ;             | C program data | 


        mov eax, [ebp + 8] ; length_1
        mov esi, [ebp + 12] ; array_1
        mov ebx, [ebp + 16] ; length_2
        mov edi, [ebp + 20] ; array_2
        mov edx, [ebp + 24] ; the array in which we'll store the merged elements from array_1 and array_2

        cmp eax, 0
        je .second_array

        cmp ebx, 0
        je .first_array

    .merging:
        ; saving on the stack the length of the first array and the length of the second array
        push eax
        push ebx

        mov eax, [esi] ; the current element from the first array
        mov ebx, [edi] ; the current element from the second array

        cmp eax, ebx
        jl .select_array_1 ; eax < ebx, select the current element from the first array to add in the merged array

        ; eax >= ebx => select the element from the second array to add in the merged array
        mov [edx], ebx

        ; restoring the values saved on the stack to update the length of the second array
        pop ebx
        pop eax

        add edi, 4
        dec ebx

        jmp .continue

    .select_array_1:
        mov [edx], eax

        ; restoring the values saved on the stack to update the length of the first array
        pop ebx
        pop eax

        add esi, 4
        dec eax

    .continue:
        add edx, 4

        cmp eax, 0
        je .end_merging

        cmp ebx, 0
        je .end_merging

        jmp .merging

    .end_merging:
        ; we have to add to the merged array the elements left in the first array or in the second array
        ; the merging process from above stops when the length of an array becomes equal with zero
        ; that means one of the arrays will still have elements not added in the final array so we'll have to add them

    .first_array:
        cmp eax, 0
        je .second_array

        mov ebx, [esi] ; the current element from the first array

        mov [edx], ebx

        add edx, 4
        add esi, 4
        dec eax

        xor ebx, ebx ; ebx = 0, cleaning ebx after using it
        jmp .first_array

    .second_array:
        cmp ebx, 0
        je .end_program

        mov eax, [edi] ; the current element from the second array

        mov [edx], eax

        add edx, 4
        add edi, 4
        dec ebx
        jmp .second_array

    .end_program:
        ; restoring the values of the saved registers
        popad

        ; restoring the stack frame
        mov esp, ebp
        pop ebp
        
        ; going to the return address
        ret



        