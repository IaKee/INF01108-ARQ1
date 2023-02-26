

# Trabalho do Cesar - 2019/2

Aqui você encontra os arquivos necessários para implementar o programa de aplicação (APP).

Os arquivos são os seguintes:

    Especificacao.pdf    -> Especificação do trabalho
    app_ref.ced          -> Arquivo sobre o qual você deve desenvolver a sua solução da APP

    krn.mem              -> Arquivo com a implementação das funções que você necessita para desenvolver a sua APP
                            Esse arquivo deverá ser carregado no simulador, ANTES de carregar seu programa de aplicação
                            Então, você deve usar CARGA PARCIAL para carregar seu programa



## CARGA PARCIAL

Procedimento para "juntar" (mesclar) o krn.mem com a sua implementação do programa de aplicação.

Esse procedimento é necessário para colocar sua implementação em execução.

Procedimento
    1) Carregue, normalmente, no simulador, o arquivo "KRN.MEM", fornecido pelo professor.
    2) Carregue, usando "carga parcial", no simulador, o seu arquivo ".mem", desenvolvido por você.
    3) Verifique se a opção "Atualizar Registradores" está desligada
    4) Zere o Program Counter (R7)
    5) Inicie a execução




## Quais os dados necessários para realizar a carga parcial no simulador?

Para realizar a carga parcial você deve usar no simulador o menu "Arquivo" >> "Carga Parcial"

O simulador solicitará, então, as seguintes informações, em ordem:
    Arquivo: selecione o seu programa de aplicação (desenvolvido sobre o APP_REF.CED)
    Endereço inicial da memória a copiar: 256 (H0100)
    Endereço final da memória a copiar: 16383 (H3FFF)
    Endereço de destino: 256 (H0100)



## Como rodar, passo a passo, sua implementação

Você deve utilizar o "break point" do simulador.

Escreva o endereço 100 (hexa) ou 256 (decimal) no campo "BP" do simulador (no canto inferior esquerdo.
Zere o Program Counter (R7)
Inicie a execução do programa

Assim que o programa atingir o endereço H100 (início de seu programa de aplicação) a execução vai parar.
A partir desse instante, você poderá executar seu programa passo a passo
	
	
