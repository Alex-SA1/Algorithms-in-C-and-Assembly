#include <stdio.h>
#include <assert.h>

// function returns the greatest common divisor for numbers a and b
// the gcd will be computed using Euclid's algorithm
/*
Euclid's algorithm (pseudocode):
while b != 0:
    r <- a % b
    a <- b
    b <- r

the result will be found in a
*/
int gcd(int a, int b);

void tests() {
    int a = 2, b = 2;
    assert(gcd(a, b) == 2);

    a = 2, b = 6;
    assert(gcd(2, 6) == 2);

    a = 3, b = 17;
    assert(gcd(a, b) == 1);

    a = 14, b = 49;
    assert(gcd(a, b) == 7);

    a = 25, b = 105;
    assert(gcd(a, b) == 5);
}

int main() {
    // running all tests for gcd function
    tests();
    printf("All tests have been passed successfully!");
    return 0;
}