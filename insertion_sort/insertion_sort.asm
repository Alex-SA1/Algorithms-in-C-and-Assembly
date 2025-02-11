bits 32 ; indicating to the processor that we are working with 32-bits instructions

; making the tag available outside of the current file
global _insertion_sort

segment code use32 class=code:
    _insertion_sort:
        ; creating a stack frame for the .asm program
        push ebp
        mov ebp, esp

        ; saving the value of all registers to restore at the end of the program
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

        ; if the length of the array is 0 we will jump to the end of the function
        jecxz .end_program

        ; we are decrementing the length of the array by 1 because we have to verify just (length - 1) values with the elements before them in the array
        ; because the first element from the array has no elements before
        dec ecx
        jecxz .end_program ; that means we have a single element in the array (the array is sorted)

        ; the elements of the array are represented on 4 bytes (data type: int) so we can store them on dwords (4 byte - registers)

        mov edi, 4 ; iterator starting from the second element of the array
    .repeat:
        mov eax, [esi + edi] ; the current element

        ; iterator for iterating over the elements before the current one
        mov edx, edi
        ; starting from the element before the current one
        sub edx, 4

        ; we will search for the correct position in the array of the current element
        ; a position is correct for the current element if the element before it is smaller and the one after it is bigger
        ; example: for the value 3 a correct positioning is 0, 3, 5
    .search:
        mov ebx, [esi + edx] ; the value to compare with the current one

        cmp eax, ebx
        jge .end_search ; eax >= ebx that means we find a correct positioning for the current element

        ; eax < ebx, we have to continue with searching for the correct position

        push eax ; we save the value of the current element to use the eax register

        mov eax, [esi + edx] ; the element compared previously
        mov [esi + edx + 4], eax ; we move the element compared previously to the right to make space for inserting the current element on the correct position

        pop eax ; restoring the value of the current element

        sub edx, 4
        cmp edx, -4 ; if edx == -4 means that we have no elements left to compare the current element with
        jne .search ; if edx != -4 we continue the search

    .end_search:
        mov [esi + edx + 4], eax ; we move the current element on the right position (his position won't be changed if it is on the right position)

        add edx, 4 ; we advance to the next element
        loop .repeat

    .end_program:
        ; restoring the values of the registers
        popad

        ; restoration of the stack frame
        mov esp, ebp
        pop ebp

        ; going to the return address
        ret
