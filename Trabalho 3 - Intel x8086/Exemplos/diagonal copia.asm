         assume cs:codigo,ds:dados,es:dados,ss:pilha

CR       EQU    0DH ; constante - codigo ASCII do caractere "carriage return"
LF       EQU    0AH ; constante - codigo ASCII do caractere "line feed"

; definicao do segmento de dados do programa
dados    segment
mensagem db     'Meu primeiro programa grafico em ASSEMBLER 8086 funciona!','$'
cor      db     ?
coluna   dw     ?
dados    ends

; definicao do segmento de pilha do programa
pilha    segment stack ; permite inicializacao automatica de SS:SP
         dw     128 dup(?)
pilha    ends
         
; definicao do segmento de codigo do programa
codigo   segment
.386
inicio:  ; CS e IP sao inicializados com este endereco
         mov    ax,dados ; inicializa DS
         mov    ds,ax    ; com endereco do segmento DADOS
         mov    es,ax    ; idem em ES
; fim da carga inicial dos registradores de segmento

; A partir daqui, as instrucoes especificas para cada programa
; Neste exemplo, o programa altera o modo de video para grafico
; e desenha uma diagonal com 480 barras horizontais coloridas,
; formadas por 160 pontos, variando a cor dos pontos em cada linha
; e iniciando no canto superior esquerdo da tela (coordenadas 0,0).
; Depois, posiciona o cursor no inicio da linha 29 e escreve uma
; mensagem na tela.
; Antes de terminar, restaura o modo de video padrao do DOS
; e devolve o controle para o sistema operacional (DOS)
         mov ah,0            ; configura video para modo grafico
         mov al,12H          ; com 480 linhas e 640 colunas de pixels
         int 10h             ; e 30 linhas e 80 colunas de texto
; inicializa coordenadas dos pixels para canto superior esquerdo
         mov cx,0            ; define coordenadas graficas do canto
         mov dx,0            ; superior esquerdo da tela (0,0)
         mov cor,0           ; cor do pixel - vai variar de 0 a 15
repete:
         call pinta_barra
         inc cor
         add dx,1            ; incrementa coordenada de linha
         add cx,1            ; incrementa coordenada de coluna
         cmp dx,480          ; se ainda nao pintou na ultima linha de pixels,           
         jle repete          ; vai pintar mais um ponto da diagonal
; posiciona cursor de texto no in�cio da �ltima linha da tela (29, neste modo)
         mov ah,2            ; posiciona o cursor de texto
         mov dl,0            ; na coluna 0
         mov dh,29           ; da linha 29
         mov bh,0            ; da pagina 0 da memoria do controlador de video
         int 10h
; escreve mensagem na ultima linha da tela 
         lea    dx,mensagem  ; endereco da mensagem em DX
         mov    ah,9         ; funcao exibir mensagem no AH
         int    21h          ; chamada do DOS
; espera que seja pressionada qualquer tecla
         call espera_tecla   ; espera que usuario digite qualquer tecla para continuar
; volta ao modo de video padrao do DOS (03H)
         mov ah,0            ; retorna ao modo de video padrao DOS
         mov al,3            ; com 25 linhas e 80 colunas de texto
         int 10h             ; e 16 cores
; retorno ao DOS com codigo de retorno 0 no AL (fim normal)
fim:
         mov    ax,4c00h     ; funcao retornar ao DOS no AH
         int    21h          ; chamada do DOS

espera_tecla PROC
         mov ah,8            ; leitura do teclado sem "eco"
         int 21h             ; espera que seja pressionada qualquer tecla
         ret
espera_tecla ENDP

pinta_barra PROC
         mov coluna,cx
         push cx             ; salva linha do pixel atual
         mov cx,160
outro_pixel:
         push cx
         mov cx,coluna
         mov ah,0CH          ; "pinta"
         mov al,cor          ; com cor variando de 0 a 255
         mov bh,0            ; um pixel na pagina zero
         int 10h             ; com coordenadas especificadas por 	CX,DX
         add coluna,1        ; incrementa coordenada de coluna
         pop cx
         loop outro_pixel

         pop cx              ; restaura linha do pixel atual
         ret
pinta_barra ENDP

codigo   ends

; a diretiva a seguir indica o fim do codigo fonte (ultima linha do arquivo)
; e informa que o programa deve come�ar a execucao no rotulo "inicio"
         end    inicio 

