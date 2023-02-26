#include <stdio.h>
#include <windows.h>
#include <string.h>
#include <conio2.h>

/*CONSIDERACOES*/
//-O maior tamanho de caminho possivel para o nome de um arquivo foi considerado como sendo 260 - Pois esse é o limite no sistema windows

/*VARIAVEIS GLOBAIS*/ //é assim que vai funcionar...
    char buffer_caminho_arquivo[260]; //Caminho maximo no windows
    FILE* arquivo_input = NULL;
    FILE* arquivo_output = NULL;
    COORD pos = {0, 0};

void apaga_caractere(int linha, int index)
{
    //Volta um caractere
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    pos.Y = linha-1;
    pos.X = index;
    SetConsoleCursorPosition(hConsole, pos);

    //Preenche com espaco e avança para a direita
    printf(" "); //Preenche com um espaco

    //Volta um caractere novamente
    SetConsoleCursorPosition(hConsole, pos);
}
int pede_arquivo()
{
    char tecla;
    int index_arquivo = 0;
    printf("Digite o nome do arquivo de entrada: ");

    while(tecla != 13) //Se a tecla pressionada nao for o carriage return (enter), continua no loop
    {
        if(kbhit)
        {
            tecla = getche();

            if(tecla != 8) //Se nao for um backspace
            {
                buffer_caminho_arquivo[index_arquivo] = tecla;
                buffer_caminho_arquivo[index_arquivo+1] = '\0';
                index_arquivo++;
            }
            else
            {
                buffer_caminho_arquivo[index_arquivo-1] = '\0'; //
                index_arquivo--; //Decrementa index arquivo
                apaga_caractere(3, index_arquivo + 37);
            }
        }

    }

    //Se a terminacao do arquivo for .txt...
    if(buffer_caminho_arquivo[index_arquivo] == 't')
        if(buffer_caminho_arquivo[index_arquivo-1] == 'x')
            if(buffer_caminho_arquivo[index_arquivo-2] == 't')
                if(buffer_caminho_arquivo[index_arquivo-3] == '.')
                    return 0;

    printf("\nexecutou aq");
    strcat(buffer_caminho_arquivo, ".txt");
    //buffer_caminho_arquivo[strlen(buffer_caminho_arquivo)+1] = '\0'; //Escreve um \0 no final do arquivo
    return 1;
}


void reseta_variaveis()
{
    //Zera as variaveis auxiliares utilizadas ao longo do programa
}
void inicializa_programa()
{
    reseta_variaveis();

    clrscr();
    printf("Nome: Giordano Souza de Paula");
    printf("\n");
    printf("Cartao UFRGS: 00308054");
    printf("\n");
}
void altera_modo_grafico()
{
    //Em C isso não é necessario...
}

int main(void)
{
    int flag_erro;

    inicializa_programa(); // ->1<-

    flag_erro = pede_arquivo(); // ->2<-

    //altera_modo_grafico(); // ->3<-

    if(flag_erro == 0)
        printf("tudo certo!");

    printf("\no conteudo da string eh: %s\n", buffer_caminho_arquivo);
    system("pause"); //HALT!

    return 0;
}
