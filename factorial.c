#include <stdio.h>

int factorial(int n)
{
    if (n <= 1)
    {
        return n;
    }

    return n * factorial(n - 1);
}

int main(void)
{
    int f;

    f = factorial(5);

    printf("%d\n", f);

    return 0;
}
