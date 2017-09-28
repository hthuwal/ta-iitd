#include <stdio.h>
#include <math.h>
int isPrime(int n)
{
    int i;
    if(n<=1)
        return 0;
    for(i=2;i<=sqrt(n);i++)
        if(n%i == 0)
            return 0;
    return 1;
}

void factors(int n)
{
    int i;
    int k=0;
    for(i=1;i<=n;i++)
    {
        if(n%i==0)
        {
            printf("%d ",i);
        }
    }
    printf("\n");
}
void primefactors(int n)
{
     while (n%2 == 0)
    {
        printf("%d ", 2);
        n = n/2;
    }
    int i;
    for (i = 3; i <= sqrt(n); i = i+2)
    {
        while (n%i == 0)
        {
            printf("%d ", i);
            n = n/i;
        }
    }
    if (n > 2)
        printf ("%d ", n);
}
int main(int argc, char *argv[])
{

    /* Write your code after this line */

   int n;
   scanf("%d",&n);
   factors(n);
   primefactors(n);
   return 0;
}
