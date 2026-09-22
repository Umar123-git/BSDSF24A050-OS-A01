#include <stdio.h>
#include <stdlib.h>

#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main(void)
{
    printf("--- Testing String Functions ---\n\n");

    char text1[] = "Operating Systems";

    printf("mystrlen(\"%s\") = %d\n",
           text1,
           mystrlen(text1));

    char source[] = "Hello Linux";
    char destination[100];

    mystrcpy(destination, source);

    printf("mystrcpy() = \"%s\"\n",
           destination);

    char limited[100];

    mystrncpy(limited, "Operating Systems", 9);

    printf("mystrncpy() = \"%s\"\n",
           limited);

    char first[100] = "Hello ";

    mystrcat(first, "World");

    printf("mystrcat() = \"%s\"\n",
           first);

    printf("\n--- Testing File Functions ---\n\n");

    FILE* file = fopen("test.txt", "w");

    if (file == NULL)
    {
        perror("Error creating test.txt");
        return 1;
    }

    fprintf(file, "Hello world\n");
    fprintf(file, "Operating Systems\n");
    fprintf(file, "Hello Linux\n");
    fprintf(file, "Python programming\n");
    fprintf(file, "Hello C programming\n");

    fclose(file);

    file = fopen("test.txt", "r");

    if (file == NULL)
    {
        perror("Error opening test.txt");
        return 1;
    }

    int lines;
    int words;
    int chars;

    if (wordCount(file, &lines, &words, &chars) == 0)
    {
        printf("wordCount():\n");
        printf("Lines      = %d\n", lines);
        printf("Words      = %d\n", words);
        printf("Characters = %d\n", chars);
    }
    else
    {
        printf("wordCount() failed.\n");
    }

    fclose(file);

    file = fopen("test.txt", "r");

    if (file == NULL)
    {
        perror("Error opening test.txt");
        return 1;
    }

    char** matches = NULL;

    int match_count = mygrep(file, "Hello", &matches);

    if (match_count >= 0)
    {
        printf("\nmygrep(\"Hello\"):\n");
        printf("Matches found = %d\n", match_count);

        for (int i = 0; i < match_count; i++)
        {
            printf("%s", matches[i]);
            free(matches[i]);
        }

        free(matches);
    }
    else
    {
        printf("mygrep() failed.\n");
    }

    fclose(file);

    printf("\nAll tests completed.\n");

    return 0;
}