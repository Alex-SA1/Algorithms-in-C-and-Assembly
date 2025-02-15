#include <stdio.h>
#include <assert.h>

// this function returns 1 if x is a prime number or 0 otherwise
int is_prime(int x);

void tests() {
    int x = -5;
    assert(is_prime(x) == 0);

    x = 0;
    assert(is_prime(x) == 0);

    x = 1;
    assert(is_prime(x) == 0);

    x = 2;
    assert(is_prime(x) == 1);

    x = 5;
    assert(is_prime(x) == 1);

    x = 49;
    assert(is_prime(x) == 0);

    x = 101;
    assert(is_prime(x) == 1);

    x = 39;
    assert(is_prime(x) == 0);

    x = 24;
    assert(is_prime(x) == 0);

    x = 29;
    assert(is_prime(x) == 1);

    x = 19;
    assert(is_prime(x) == 1);

    x = 18;
    assert(is_prime(x) == 0);

    x = 121;
    assert(is_prime(x) == 0);

    x = 11;
    assert(is_prime(x) == 1);
}

int main() {
    // running all tests for is_prime function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}