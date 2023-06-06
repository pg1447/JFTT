
#include<stdio.h>
#include<string.h>

int main()
{
   char txt[] = "AABABABAAABABBABBBBAAAABABBAABBBAABABBBAAAAABBBBBBAABABBBBABBBAAABABABABBBBAAABABAABABABBABBBBAABAAAABBAABBAAABBABAABBAAABBAABA";
   char wzo[] = "AABA";
   search(wzo, txt);
   return 0;
}


void search(char *wzo, char *txt)
{
    int M = strlen(wzo);
    int N = strlen(txt);



    int i;
    for (i = 0; i <= N - M; i++)
    {
        int j;


        for (j = 0; j < M; j++)
            if (txt[i+j] != wzo[j])
                break;

        if (j == M)
           printf("Wzorzec znaleziony na indeksie %d \n", i);
    }
}

