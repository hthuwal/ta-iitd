#include <stdio.h>
#include <math.h>

int main()
{
    double pi;

    double first = 1103;
    double second = ( (double) 4 * 3 * 2) * (26390 + 1103) / pow(396.0, 4);
    double third = ( (double) 8 * 7 * 6 * 5 * 4 * 3 * 2) * (26390 * 2 + 1103) / (pow(2, 4) * pow(396.0, 8));
    double fourth = ( (double) 12 * 11 * 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2) * (26390 * 3 + 1103) / (pow(6, 4) * pow(396.0, 12));

    double sum = first + second + third + fourth;

    double rhs = (sqrt(8.0) / 9801) * sum;

    pi = 1 / rhs;

    printf("%.17lf", pi);

    return 0;
}
