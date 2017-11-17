#include <stdio.h>

int main()
{

    // Store the five numbers in these variables
    int num1, num2, num3, num4, num5;

    // Store the sum in this variable
    int sum;

    // Write your code here

    scanf("%d", &num1);
    scanf("%d", &num2);
    scanf("%d", &num3);
    scanf("%d", &num4);
    scanf("%d", &num5);

    sum = num1 + num2 + num3 + num4 + num5;

    printf("%d", sum);

   return 0;
}
