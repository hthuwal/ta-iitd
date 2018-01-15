#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[])
{
    int a[50];
    int n,i,j;
    scanf("%d",&n);
    j=0;
    for(i=1;i<=n;i++)
    {
        if(n%i==0)
        {
            a[j]=i;
            printf("%d ",a[j]);
            j++;
        }
        
    }
    
    
    printf("\n");
    j=0;
    while(a[j]>0 && j<50)
    {
    for(i=2;i<a[j];i++)
    
        if(a[j]%i==0)
        break;
        
        if(i==a[j])
        {
            printf("%d ",i);
        }
        j++;
    }
   return 0;
}
