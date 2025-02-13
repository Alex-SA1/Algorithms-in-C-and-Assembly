#include <stdio.h>
#include <assert.h>

// the function computes number ^ power (where "^" mean exponentiation)
int fast_exponentiation(int number, int power);

void tests() {
    int number = 10, power = 0;
    assert(fast_exponentiation(number, power) == 1);

    number = 3, power = 1;
    assert(fast_exponentiation(number, power) == 3);

    number = 5, power = 3;
    assert(fast_exponentiation(number, power) == 125);

    number = 3, power = 8;
    assert(fast_exponentiation(number, power) == 6561);

    number = -4, power = 2;
    assert(fast_exponentiation(number, power) == 16);

    number = -4, power = 3;
    assert(fast_exponentiation(number, power) == -64);

    number = 2, power = 30;
    assert(fast_exponentiation(number, power) == 1 << 30);
    // 1<<30 = 1 * (2 ^ 30)
}

int main() {

    // running all tests for fast_exponentiation function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}