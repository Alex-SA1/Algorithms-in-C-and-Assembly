#include <stdio.h>
#include <assert.h>

// function returns 1 if x is found in the array or 0 otherwise
// array is sorted in ascending order
int binary_search(int length, int array[], int x);

void tests() {
    int n = 50, array_1[] = {-869, -378, -246, 1194, 1810, 2009, 2555, 2604, 2773, 3044, 3601, 4171, 4234, 4332, 4333, 4336, 4469, 4507, 4670, 
        4701, 4703, 5011, 5115, 5337, 5989, 6018, 6266, 6268, 6298, 6326, 6624, 6777, 6951, 7016, 7032, 7136, 7242, 7271, 7485, 7648, 7732, 
        8554, 8573, 8991, 9449, 9451, 9591, 9850, 9885, 9898};
    int x = 6298;
    assert(binary_search(n, array_1, x) == 1);

    x = -1000;
    assert(binary_search(n, array_1, x) == 0);

    x = 10000;
    assert(binary_search(n, array_1, x) == 0);

    n = 0;
    int array_2[] = {};
    x = 10;
    assert(binary_search(n, array_2, x) == 0);

    n = 1;
    int array_3[] = {6};
    x = 6;
    assert(binary_search(n, array_3, x) == 1);

    n = 1;
    int array_4[] = {10};
    x = 11;
    assert(binary_search(n, array_4, x) == 0);
}

int main() {
    // running all tests for binary_search function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}