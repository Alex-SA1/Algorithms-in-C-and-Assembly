#include <stdio.h>
#include <assert.h>

void bubble_sort(int length, int array[]);

void tests() {
    int n = 20, array_1[] = {-445, -908, -140, 637, 467, -978, 501, 256, -296, 201, -27, -836, 910, 779, -702, 165, -444, -405, 618, 945};
    int sorted_array_1[] = {-978, -908, -836, -702, -445, -444, -405, -296, -140, -27, 165, 201, 256, 467, 501, 618, 637, 779, 910, 945};

    bubble_sort(n, array_1);

    for(int i = 0; i < n; i++)
        assert(array_1[i] == sorted_array_1[i]);

    n = 100;
    int array_2[] = {418, -457, 249, 965, 672, -788, 66, 913, 914, -485, -764, 4, -608, 856, -678, 468, -314, -741, 98, 78, -676, 523, 
        -539, -287, 157, 570, 526, 749, 880, -818, 927, 948, -792, 5, -25, 708, 376, 628, 579, -439, -667, 146, -673, 215, -672, 907, 
        -288, 272, 675, -254, 530, -32, 244, -614, -29, -60, 297, -148, -561, -130, -355, 518, -385, -202, 315, -44, -710, 522, -915, 
        767, 589, 869, 690, 164, 972, 646, 36, -587, 794, 521, 14, -698, 655, 
        -689, 76, 854, -22, 591, 516, 439, 398, -64, -244, 980, 512, -869, 578, -845, 924, 68};
    int sorted_array_2[] = {-915, -869, -845, -818, -792, -788, -764, -741, -710, -698, -689, -678, -676, -673, -672, -667, -614, -608, 
        -587, -561, -539, -485, -457, -439, -385, -355, -314, -288, -287, -254, -244, -202, -148, -130, -64, -60, -44, -32, -29, -25, -22, 4, 
        5, 14, 36, 66, 68, 76, 78, 98, 146, 157, 164, 215, 244, 249, 272, 297, 315, 376, 398, 418, 439, 468, 512, 516, 518, 521, 522, 523, 526, 
        530, 570, 578, 579, 589, 591, 628, 646,
         655, 672, 675, 690, 708, 749, 767, 794, 854, 856, 869, 880, 907, 913, 914, 924, 927, 948, 965, 972, 980};
    
    bubble_sort(n, array_2);

    for(int i = 0; i < n; i++)
        assert(array_2[i] == sorted_array_2[i]);

    n = 0;
    int array_3[] = {};

    bubble_sort(n, array_3);

    n = 1;
    int array_4[] = {10};

    bubble_sort(n, array_4);

    assert(array_4[0] == 10);
}

int main() {
    //running all tests for bubble_sort function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}