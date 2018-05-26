#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[])
{

    /* Write your code after this line */
    int i,j,s,a;
    int n;
    scanf("%d" ,&n);
    for(a=1;a<=n;a++)
    {
    if (n%a==0)
    {
        printf("%d " ,a);
    }
    }
    printf("\n");
    int k;
    k=n;
    while(k>0)
    {
     for(i=2;i<k;i++)
     {
        if(k%i==0)
       {
            for(j=2;j<i;j++)
        {
    
        if(i%j==0)
        {
            continue;
        }
        else
        {
            printf("%d" ,i);
            
            break;
        }
        s=i;
        }
        
        }
      
      break;
      
     }
     k=k/s;
    }

       
   return 0;
}
