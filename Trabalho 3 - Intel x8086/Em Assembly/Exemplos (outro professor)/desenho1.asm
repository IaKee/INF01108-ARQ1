         assume cs:codigo,ds:dados,es:dados,ss:pilha

CR       EQU    0DH ; constante - codigo ASCII do caractere "carriage return"
LF       EQU    0AH ; constante - codigo ASCII do caractere "line feed"

; definicao do segmento de dados do programa
dados     segment
asterisco db    '*$'
atributo  db    17h ; fundo azul (1), texto em cinza claro (7)
dados     ends

; definicao do segmento de pilha do programa
pilha    segment stack ; permite inicializacao automatica de SS:SP
         dw     128 dup(?)
pilha    ends
         
; definicao do segmento de codigo do programa
codigo   segment
inicio:  ; CS e IP sao inicializados com este endereco
         mov    ax,dados ; inicializa DS
         mov    ds,ax    ; com endereco do segmento DADOS
         mov    es,ax    ; idem em ES
; fim da carga inicial dos registradores de segmento

; a partir daqui, as instrucoes especificas para este programa
; usando a rolagem de janela para limpar toda a tela
; como se fosse uma janela desde (0,0) até (24,79)
rolartela:
          mov   al,0        ; rolar todas as linhas da janela
          mov   bh,atributo ; inserir novas linhas com este atributo
          mov   ch,0        ; linha do canto superior esquerdo da janela
          mov   cl,0        ; coluna do canto superior esquerdo da janela
          mov   dh,24       ; linha do canto inferior direito da janela
          mov   dl,79       ; coluna do canto inferior direito da janela
          mov   ah,6        ; rolar janela para cima
          int   10h         ; executa rolagem

; exemplo de instruções para posicionar cursor      
          mov   dh,0        ; linha 0
          mov   dl,0        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela

;  exemplo de instrução para escrever um '*' na posicao em que esta o cursor
          call  asterisca   ; escreve um '*' nesta posicao

; exemplo de mais algumas linhas ...
          mov   dh,0        ; linha 0
          mov   dl,79        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,1        ; linha 0
          mov   dl,1        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,1        ; linha 0
          mov   dl,78        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,2        ; linha 0
          mov   dl,2        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,2        ; linha 0
          mov   dl,77        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,3        ; linha 0
          mov   dl,3        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao
          mov   dh,3        ; linha 0
          mov   dl,76        ; coluna 0
          call  poscursor   ; posiciona cursor na posicao (0,0) da tela
          call  asterisca   ; escreve um '*' nesta posicao


; substitua os exemplos acima por uma serie de instrucoes que "desenhe"
; com asteriscos na tela o seguinte (configure página para paisagem):
;             1         2         3         4         5         6         7
;   01234567890123456789012345678901234567890123456789012345678901234567890123456789 
;  0*                                                                              * 0
;  1 *                                                                            *  1
;  2  *                                                                          *   2
;  3   *                                                                        *    3
;  4    *                                                                      *     4
;  5     *                                                                    *      5
;  6      *                                                                  *       6
;  7       *                                                                *        7
;  8        *                                                              *         8
;  9         *                                                            *          9
; 10          *                                                          *          10
; 11           *                                                        *           11
; 12            ********************************************************            12
; 13           *                                                        *           13
; 14          *                                                          *          14
; 15         *                                                            *         15
; 16        *                                                              *        16
; 17       *                                                                *       17
; 18      *                                                                  *      18
; 19     *                                                                    *     19
; 20    *                                                                      *    20
; 21   *                                                                        *   21
; 22  *                                                                          *  22
; 23 *                                                                            * 23
; 24*                                                                              *24
;   01234567890123456789012345678901234567890123456789012345678901234567890123456789 
;             1         2         3         4         5         6         7

          
; antes de terminar o programa, espera que uma tecla seja pressionada
; para que o usuario possa apreciar a "obra de arte"  :-)
          call  espera_tecla 
          jmp   fim         ; vai terminar o programa

poscursor proc ; posiciona o cursor na linha dada por DH e coluna dada por DL
          mov    ah,2       ; funcao posicionar cursor
          mov    bh,0       ; pagina 0 da memoria da placa de video
          int    10h        ; chama o servico do BIOS
          ret
poscursor endp

asterisca proc ; escreve um '*' na tela, na posicao onde esta o cursor
          lea    dx,asterisco ; endereco da mensagem (terminada por $) em DX
          mov    ah,9         ; funcao exibir mensagem no AH
          int    21h          ; chamada do DOS
          ret
asterisca endp

espera_tecla proc ; espera até uma tecla qualquer ser pressionada e retorna
          mov    ah,8         ; ler caractere sem ecoar na tela
          int    21h          ; chama servico do DOS
          ret                 ; qualquer que seja a tecla, retorna
espera_tecla endp

; retorno ao DOS com codigo de retorno 0 no AL (fim normal)
fim:
         mov    ax,4c00h           ; funcao retornar ao DOS no AH
         int    21h                ; chamada do DOS

codigo   ends

; a diretiva a seguir indica o fim do codigo fonte (ultima linha do arquivo)
; e informa que o programa deve comecar a execucao no rotulo "inicio"
         end    inicio 

