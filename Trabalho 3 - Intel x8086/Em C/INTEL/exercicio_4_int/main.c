#include <stdio.h>
#include <stdlib.h>

int main()
{
    int numeroaluno;
    float nota1;
    float nota2;
    float nota3;
    float media;
    printf("Informe o numero do aluno: ");
    scanf("%d", &numeroaluno);
    printf("\nInforme a nota 1: ");
    scanf("%f", &nota1);
    printf("\nInforme a nota 2: ");
    scanf("%f", &nota2);
    printf("\nInforme a nota 3: ");
    scanf("%f", &nota3);
    media = (nota1 + nota2 + nota3)/3;
    printf("\nA media do aluno %d e: %f", numeroaluno, media);
    return 0;
}
