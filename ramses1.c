#include <stdio.h>
#include <stdlib.h>

#define STR_SIZE	80

/** Programa RAMSES */
unsigned char x1,x2;

void ramses() {
    x1 = x1 + x2;
}
/** FIM do programa RAMSES */

int main()
{
    char str[80];

    /* Carga das variáveis que estão mapeadas na memória */
    printf("Valor de x1 = ");
    fgets(str, STR_SIZE, stdin);
    x1 = atoi(str);
    printf("Valor de x2 = ");
    fgets(str, STR_SIZE, stdin);
    x2 = atoi(str);

    /* Executa o programa no RAMSES */
    ramses();

    /* Coloca na tela o resultado do programa RAMSES */
    printf("x1=%d, x2=%d\n", x1, x2);
    return 0;
}
