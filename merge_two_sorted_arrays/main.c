#include <stdio.h>
#include <assert.h>

// array_1 and array_2 are sorted in ascending order
// the function merges these two sorted arrays and puts the elements sorted in ascending order in the merged array
void merge(int length_1, int array_1[], int length_2, int array_2[], int merged[]);

void tests() {
    int n = 3, m = 6, array_1_1[] = {-2, -1, 5}, array_2_1[] = {-12, -5, -1, 4, 8, 24}, merged_1[9] = {};
    int correct_merged_1[] = {-12, -5, -2, -1, -1, 4, 5, 8, 24};
    merge(n, array_1_1, m, array_2_1, merged_1);

    for (int i = 0; i < n + m; i++)
        assert(merged_1[i] == correct_merged_1[i]);

    n = 0, m = 5;
    int array_1_2[] = {}, array_2_2[] = {1, 2, 3, 4, 5}, merged_2[5] = {};
    merge(n, array_1_2, m, array_2_2, merged_2);

    for (int i = 0; i < m; i++)
        assert(array_2_2[i] == merged_2[i]);

    n = 5, m = 0;
    int array_1_3[] = {1, 2, 3, 4, 5}, array_2_3[] = {}, merged_3[5] = {};
    merge(n, array_1_3, m, array_2_3, merged_3);

    for (int i = 0; i < n; i++)
        assert(array_1_3[i] == merged_3[i]);

    n = 3, m = 3;
    int array_1_4[] = {1, 4, 8}, array_2_4[] = {1, 5, 6}, merged_4[6] = {};
    int correct_merged_4[] = {1, 1, 4, 5, 6, 8};
    merge(n, array_1_4, m, array_2_4, merged_4);

    for (int i = 0; i < n + m; i++)
        assert(merged_4[i] == correct_merged_4[i]);

    n = 5, m = 4;
    int array_1_5[] = {4, 10, 90, 120, 400}, array_2_5[] = {3, 56, 72, 99}, merged_5[9] = {};
    int correct_merged_5[] = {3, 4, 10, 56, 72, 90, 99, 120, 400};
    merge(n, array_1_5, m, array_2_5, merged_5);

    for (int i = 0; i < n + m; i++)
        assert(merged_5[i] == correct_merged_5[i]);
}

int main() {
    // running all tests for merge function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}