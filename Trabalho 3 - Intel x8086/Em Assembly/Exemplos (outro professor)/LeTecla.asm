         assume cs:codigo,ds:dados,es:dados,ss:pilha

CR       EQU    0DH ; constante - codigo ASCII do caractere "carriage return"
LF       EQU    0AH ; constante - codigo ASCII do caractere "line feed"
ESCAPE   EQU    1BH ; constante - codigo ASCII do caractere "escape"

; definicao do segmento de dados do programa
dados    segment

mensagD  db     CR,LF,'Foi lido o digito '
digito   db     ?
         db     ' !',CR,LF,'$'

mensagL  db     CR,LF,'Foi lida a letra '
letra    db     ?
         db     ' !',CR,LF,'$'

mensagN  db     CR,LF,'Foi lido um '
char     db     ?
         db     ', que nao e'' um digito nem uma letra !',CR,LF,'$'

dados    ends

; definicao do segmento de pilha do programa
pilha    segment stack ; permite inicializacao automatica de SS:SP
         dw     128 dup(?)
pilha    ends
         
; definicao do segmento de codigo do programa
codigo   segment
inicio:  ; CS e IP sao inicializados com este endereco
         mov    ax,dados  ; inicializa DS
         mov    ds,ax     ; com endereco do segmento DADOS
         mov    es,ax     ; idem em ES
; fim da carga inicial dos registradores de segmento

; a partir daqui, as instrucoes especificas para cada programa
; neste exemplo, o programa faz a leitura de caracteres digitados no
; teclado, analisa o que leu e exibe na tela uma mensagem informando 
; que tipo de caractere foi lido; se leu ESC, termina a execucao

ler_tecla:
         mov    ah,1      ; le um caractere do teclado e escreve na tela
         int    21h       ; caractere lido volta no registrador AL
         cmp    al,ESCAPE ; se ESC, termina a execucao do programa
         je     fim

         cmp    al,'0'
         jb     naoera    ; abaixo de '0', nenhum digito ou letra
         cmp    al,'9'
         jbe    eradigito ; se '0' <= AL <= '9', era um digito
   
         cmp    al,'A'
         jb     naoera    ; entre '9' e 'A', nenhum digito ou letra
         cmp    al,'Z'
         jbe    eraletra  ; se 'A' <= AL <= 'Z', era uma letra
         
         cmp    al,'a'
         jb     naoera    ; entre 'Z' e 'a', nenhum digito ou letra
         cmp    al,'z'
         jbe    eraletra  ; se 'a' <= AL <= 'z', era uma letra
         jmp    naoera
         
eraletra:
         mov    letra,al           ; coloca letra lida na mensagem
         lea    dx,mensagL         ; endereco da mensagem em DX
         mov    ah,9               ; funcao exibir mensagem no AH
         int    21h                ; chamada do DOS
         jmp    ler_tecla

eradigito:
         mov    digito,al          ; coloca digito lido na mensagem
         lea    dx,mensagD         ; endereco da mensagem em DX
         mov    ah,9               ; funcao exibir mensagem no AH
         int    21h                ; chamada do DOS
         jmp    ler_tecla

naoera:
         mov    char,al            ; coloca caractere lido na mensagem
         lea    dx,mensagN         ; endereco da mensagem em DX
         mov    ah,9               ; funcao exibir mensagem no AH
         int    21h                ; chamada do DOS
         jmp    ler_tecla

; retorno ao DOS com codigo de retorno 0 no AL (fim normal)
fim:
         mov    ax,4c00h           ; funcao retornar ao DOS no AH
         int    21h                ; chamada do DOS

codigo   ends

; a diretiva a seguir indica o fim do codigo fonte (ultima linha do arquivo)
; e informa que o programa deve come‡ar a execucao no rotulo "inicio"
         end    inicio 

