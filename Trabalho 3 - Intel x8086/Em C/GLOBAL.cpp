#include <stdio.h>
#include <stdio.h>
#include <windows.h>
#include <string.h>
#include <graphics.h>
#include <conio.h>
#include <stdlib.h>
#include <dos.h>

/*CONSIDERACOES*/
//-O maior tamanho de caminho possivel para o nome de um arquivo foi considerado como sendo 260 - Pois esse é o limite no sistema windows

/*VARIAVEIS GLOBAIS*/
char buffer_caminho_arquivo[12]; //Caminho maximo solicitado
char output_path[12];
FILE* arquivo_input = NULL;
FILE* arquivo_output = NULL;
    //LADRILHOS
    int cor_preto = 0;
    int cor_azul = 0;
    int cor_verde = 0;
    int cor_ciano = 0;
    int cor_vermelho = 0;
    int cor_magenta = 0;
    int cor_marrom = 0;
    int cor_cinza_claro = 0;
    int cor_cinza_escuro = 0;
    int cor_azul_claro = 0;
    int cor_verde_claro = 0;
    int cor_ciano_claro = 0;
    int cor_vermelho_claro = 0;
    int cor_magenta_claro = 0;
    int cor_amarelo = 0;
int largura, altura; //Dados da parede
int flag_erro = 404;
int erro_aconteceu_arquivo = 0;

/*PROTOTIPACAO DAS FUNCOES*/
void apaga_caractere(int linha, int index);
int pede_arquivo();
void reseta_variaveis();
void inicializa_programa();
void altera_modo_grafico();
void move_cursor(int x, int y);
int abre_arquivos();
void le_dados_arquivo();
void imprime_quadrado(int x, int y, int cor);
void opera_arquivo();
void teste_passou();

int main(void)
{

    int gd = DETECT, gm, color;
    initgraph(&gd, &gm, "");

    //altera_modo_grafico(80x25); // inicio

    inicializa_programa(); // ->1<-

    while(flag_erro != 1) //->2<-
    {
        if(erro_aconteceu_arquivo == 1)
        {
            move_cursor(0,1);
            printf("Ocorreu um erro ao tentar abrir o arquivo, por favor tente novamente....");
            move_cursor(37,2);
            printf("            ");
            move_cursor(0,2);
        }
        buffer_caminho_arquivo[0] = '\0'; //Reseta a string

        flag_erro = pede_arquivo(); // ->2<-
        if(flag_erro == 2)
        {
            system("cls");
            printf("Usuario solicitou encerramento do programa...");
            printf("\nEncerrando...");
            fclose(arquivo_input);
            fclose(arquivo_output);
            return 2;
        }
        if(flag_erro == 1)
            flag_erro = abre_arquivos();

        if(flag_erro == 404)
            erro_aconteceu_arquivo = 1;
    }

    //altera_modo_grafico(640x480); // ->3<-

    le_dados_arquivo(); // ->4<-


    opera_arquivo(); // ->5<-

    //Fecha os arquivos texto, para esses nao serem corrompidos
    //fclose(arquivo_input);
    fclose(arquivo_output);

    move_cursor(0,19);
    printf("Atingiu o fim da main!");
    system("pause"); //STOP RIGHT THERE CRIMINAL SCUM!

    return 0;
}

void apaga_caractere(int linha, int index)
{
    //Volta um caractere
    COORD pos = {0, 0};
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

    buffer_caminho_arquivo[0] = '\0';

    while(tecla != 13) //Se a tecla pressionada nao for o carriage return (enter), continua no loop
    {

        if(_kbhit())
        {

            tecla = _getche();


            if(tecla != 8) //Se nao for um backspace
            {
                buffer_caminho_arquivo[index_arquivo] = tecla;
                buffer_caminho_arquivo[index_arquivo+1] = '\0';
                index_arquivo = strlen(buffer_caminho_arquivo);
            }
            else
            if(tecla != 13)
            {
                if(index_arquivo > 0)
                {
                    buffer_caminho_arquivo[index_arquivo-1] = '\0'; //
                    index_arquivo = strlen(buffer_caminho_arquivo);
                    apaga_caractere(3, index_arquivo + 37);
                }
                if(index_arquivo <= 0)
                {
                    move_cursor(37, 2);
                }
            }
        }
        if (strlen(buffer_caminho_arquivo) >= 9)
            return 404;
    }
    if (strlen(buffer_caminho_arquivo) > 1)
        if (buffer_caminho_arquivo[0] != 'a')
                if (buffer_caminho_arquivo[0] != 'b')
                    if (buffer_caminho_arquivo[0] != 'c')
                        if (buffer_caminho_arquivo[0] != 'd')
                            if (buffer_caminho_arquivo[0] != 'e')
                                if (buffer_caminho_arquivo[0] != 'f')
                                    if (buffer_caminho_arquivo[0] != 'g')
                                        if (buffer_caminho_arquivo[0] != 'h')
                                            if (buffer_caminho_arquivo[0] != 'i')
                                                if (buffer_caminho_arquivo[0] != 'j')
                                                    if (buffer_caminho_arquivo[0] != 'k')
                                                        if (buffer_caminho_arquivo[0] != 'l')
                                                            if (buffer_caminho_arquivo[0] != 'm')
                                                                if (buffer_caminho_arquivo[0] != 'n')
                                                                    if (buffer_caminho_arquivo[0] != 'o')
                                                                        if (buffer_caminho_arquivo[0] != 'p')
                                                                            if (buffer_caminho_arquivo[0] != 'q')
                                                                                if (buffer_caminho_arquivo[0] != 'r')
                                                                                    if (buffer_caminho_arquivo[0] != 's')
                                                                                        if (buffer_caminho_arquivo[0] != 't')
                                                                                            if (buffer_caminho_arquivo[0] != 'u')
                                                                                                if (buffer_caminho_arquivo[0] != 'v')
                                                                                                    if (buffer_caminho_arquivo[0] != 'w')
                                                                                                        if (buffer_caminho_arquivo[0] != 'x')
                                                                                                            if (buffer_caminho_arquivo[0] != 'y')
                                                                                                                if (buffer_caminho_arquivo[0] != 'z')
                                                                                                                    return 404;

    if(strlen(buffer_caminho_arquivo)-1 == 0) //Se a string estiver vazia e o ENTER for pressionado, encerra o programa
    {
        return 2;
    }

    //Verifica a terminacao do arquivo em TXT - no trabalho vai ser .PAR
    if(buffer_caminho_arquivo[index_arquivo-5] == '.')
        if(buffer_caminho_arquivo[index_arquivo-4] == 't')
            if(buffer_caminho_arquivo[index_arquivo-3] == 'x')
                if(buffer_caminho_arquivo[index_arquivo-2] == 't')
                    return 1; //Se tiver a terminacao correta, faz o jump terminando a subrotina

    //Se nao tiver a terminacao correta, insere-a
    //NO INTEL É PARA SER PAR
    buffer_caminho_arquivo[index_arquivo-1] = '.';
    buffer_caminho_arquivo[index_arquivo] = 't';
    buffer_caminho_arquivo[index_arquivo+1] = 'x';
    buffer_caminho_arquivo[index_arquivo+2] = 't';
    buffer_caminho_arquivo[index_arquivo+3] = '\0';
    return 1;
}
void reseta_variaveis()
{
    //Zera as variaveis auxiliares utilizadas ao longo do programa
}
void inicializa_programa()
{
    reseta_variaveis();
    system("cls");
    printf("Nome: Giordano Souza de Paula");
    printf(" ********* ");
    printf("Cartao UFRGS: 00308054");
    move_cursor(0,1);
}
void altera_modo_grafico()
{
    //Em C isso não é necessario...
}
void move_cursor(int x, int y)
{
    COORD pos = {x, y};
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(hConsole, pos);
}
int abre_arquivos()
{

    strcpy(output_path, buffer_caminho_arquivo);
    int index = strlen(output_path);



    //É para ser REL no INTEL
    output_path[index-4] = '2';
    output_path[index-3] = '.';
    output_path[index-2] = 't';
    output_path[index-1] = 'x';
    output_path[index]   = 't';
    output_path[index+1] = '\0';

    /*ABRE ARQUIVOS*/
    arquivo_input = fopen(buffer_caminho_arquivo, "r");
    if(arquivo_input == NULL)
        return 404;

    arquivo_output = fopen(output_path, "w+");
    if(arquivo_output == NULL)
        return 404;
    return 1;
}
void le_dados_arquivo()
{
    int number;
    char info[7]; //Considerando que o maior tamnho de matriz seja de 99x99

    fgets(info, 6, arquivo_input);

    number = atoi(info);
    altura = number;

    info[0] = '0';
    info[1] = '0';
    info[2] = '0';

    number = atoi(info);
    largura = number;
}
void imprime_quadrado(int linha, int coluna, int cor)
{
    teste_passou();
    putpixel(linha*15, coluna*15, cor);

}
void opera_arquivo()
{
    int tamanho_tela_x = 80;
    int tamanho_tela_y = 20;

    char ladrilho;
    int taxa_largura = tamanho_tela_x/largura;
    int taxa_altura = tamanho_tela_y/altura;

    printf("\nA taxa de largura eh: %d - A da altura eh: %d", taxa_largura, taxa_altura);

    fseek(arquivo_input, 5, SEEK_SET);

    for(int q=0; q < altura; q++)
    {
        move_cursor(0,3+q);
        for(int p = 0; p < largura; p++)
        {
            fscanf(arquivo_input, "%c", &ladrilho);
            if(ladrilho == '0')
                cor_preto += 1;
            if(ladrilho == '1')
                cor_azul += 1;
            if(ladrilho == '2')
                cor_verde += 1;

            for(int j=0; j < taxa_largura; j++)
                imprime_quadrado(taxa_largura*p+j, q+3, ladrilho);
        }
    }

    move_cursor(0,22);
    printf("Arquivo de entrada: %s - De saida: %s - Total de ladrilhos por cor:", buffer_caminho_arquivo, output_path);

    imprime_quadrado(1, 23, 0); //Preto
    move_cursor(1,24);
    printf("%d", cor_preto);
    imprime_quadrado(3, 23, 1); //Azul
    move_cursor(3,24);
    printf("%d", cor_azul);
    imprime_quadrado(5, 23, 2); //Verde
    move_cursor(5,24);
    printf("%d", cor_verde);
    imprime_quadrado(7, 23, 3); //Ciano
    move_cursor(7,24);
    printf("%d", cor_ciano);
    imprime_quadrado(9, 23, 4); //Vermelho
    move_cursor(9,24);
    printf("%d", cor_vermelho);
    imprime_quadrado(11, 23, 5); //Magenta
    move_cursor(11,24);
    printf("%d", cor_magenta);
    imprime_quadrado(13, 23, 6); //Marrom
    move_cursor(13,24);
    printf("%d", cor_marrom);
    imprime_quadrado(15, 23, 7); //Cinza claro
    move_cursor(15,24);
    printf("%d", cor_cinza_claro);
    imprime_quadrado(17, 23, 8); //Cinza escuro
    move_cursor(17,24);
    printf("%d", cor_cinza_escuro);
    imprime_quadrado(19, 23, 9); //Azul claro
    move_cursor(19,24);
    printf("%d", cor_azul_claro);
    imprime_quadrado(21, 23, 10); //Verde claro
    move_cursor(21,24);
    printf("%d", cor_verde_claro);
    imprime_quadrado(23, 23, 11); //Ciano claro
    move_cursor(23,24);
    printf("%d", cor_ciano_claro);
    imprime_quadrado(25, 23, 12); //Vermelho claro
    move_cursor(25,24);
    printf("%d", cor_vermelho_claro);
    imprime_quadrado(27, 23, 13); //Magenta claro
    move_cursor(27,24);
    printf("%d", cor_magenta_claro);
    imprime_quadrado(29, 23, 14); //Amarelo
    move_cursor(29,24);
    printf("%d", cor_amarelo);
}
void teste_passou()
{
    printf("passou por aq");
    system("pause");
}

