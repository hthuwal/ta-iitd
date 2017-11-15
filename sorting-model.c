#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct record{
    char name[50];
    char dob[50];
    char x[50];
    char y[50];
};

int comp_name(struct record a,struct record b)
{
  return strcmp(a.name, b.name) < 0 ? 1 : 0;
}

int comp_dob(struct record a,struct record b)
{
  char year1[5], year2[5];
  char m1[3], m2[3];
  char d1[3], d2[3];

  strncpy(year1, a.dob + 4, 4);
  strncpy(year2, b.dob + 4, 4);
  year1[4]='\0';
  year2[4]='\0';

  strncpy(m1, a.dob + 2, 2);
  strncpy(m2, b.dob + 2, 2);
  m1[2]='\0';
  m2[2]='\0';

  strncpy(d1, a.dob, 2);
  strncpy(d2, b.dob, 2);
  d1[2]='\0';
  d2[2]='\0';

  if(atoi(year1) < atoi(year2))
      return 1;
  else if(atoi(year1) > atoi(year2))
      return 0;

  if(atoi(m1) < atoi(m2))
      return 1;
  else if(atoi(m1) > atoi(m2))
      return 0;

  if(atoi(d1) < atoi(d2))
      return 1;

  return 0;
    
}

void sort( struct record records[], int n)
{
  int i,j,min;
  for(i=0;i<n;i++)
  {
    min = i;
    for(j=i+1;j<n;j++)
    {
      if(comp_name(records[j],records[min]))
        min=j;
    }
    struct record temp;
    strcpy(temp.name, records[min].name);
    strcpy(temp.dob, records[min].dob);
    strcpy(temp.x, records[min].x);
    strcpy(temp.y, records[min].y);

    strcpy(records[min].name, records[i].name);
    strcpy(records[min].dob, records[i].dob);
    strcpy(records[min].x, records[i].x);
    strcpy(records[min].y, records[i].y);

    strcpy(records[i].name,temp.name);
    strcpy(records[i].dob,temp.dob);
    strcpy(records[i].x,temp.x);
    strcpy(records[i].y,temp.y);
  }
}

int main(int argc, char *argv[])
{
  /* Write your code after this line */
  struct record records[1000];

  int n,i;
  
  scanf("%d",&n);
  
  for(i=0;i<n;i++)
  {
     scanf("%s %s %s %s",records[i].name,records[i].dob,records[i].x,records[i].y);
  }

  sort(records, n);

  for(i=0;i<n;i++)
  {
     printf("%s %s %s %s\n",records[i].name,records[i].dob,records[i].x,records[i].y);
  }
return 0;
}
