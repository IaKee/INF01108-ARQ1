         assume cs:codigo,ds:dados,es:dados,ss:pilha

CR       EQU    0DH ; constante - codigo ASCII do caractere "carriage return"
LF       EQU    0AH ; constante - codigo ASCII do caractere "line feed"

; definicao do segmento de dados do programa
dados    segment
inidados db     '>>> Inicio do segmento DADOS <<<'
baite    db     255
palavra  dw     65535
digitos1 db     '1','2'
digitos2 dw     '34'
espaco   db     ' '
mensagem db     'Programa para demonstrar o uso do depurador TD',CR,LF,'$'
dados    ends

; definicao do segmento de pilha do programa
pilha    segment stack ; permite inicializacao automatica de SS:SP
         dw     128 dup('@@')
pilha    ends
         
; definicao do segmento de codigo do programa
codigo   segment
inicio:  ; CS e IP sao inicializados com este endereco
         mov    ax,dados ; inicializa DS
         mov    ds,ax    ; com endereco do segmento DADOS
         mov    es,ax    ; idem em ES
; fim da carga inicial dos registradores de segmento
;
; a partir daqui, as instrucoes especificas para cada programa
; neste exemplo, o programa apenas exibe uma mensagem na tela 
; e devolve o controle para o sistema operacional (DOS)
         lea    dx,mensagem          ; endereco da mensagem em DX
         mov    ah,9                 ; funcao exibir mensagem no AH
         int    21h                  ; chamada do DOS
;
         mov    ax,palavra           ; AX = FFFFh
         mov    cl,digitos1          ; CL = 31h
         mov    ch,byte ptr digitos2 ; CH = 33h
         mov    dl,baite             ; DL = FFh
         call   subrot
         mov    palavra,ax           ; palavra = 
         mov    digitos2,cx          ; digitos2 = 
; retorno ao DOS com codigo de retorno 0 no AL (fim normal)
fim:
         mov    ax,4c00h           ; funcao retornar ao DOS no AH
         int    21h                ; chamada do DOS

subrot   proc
         inc    al
         dec    ah
         xchg   ax,cx
         inc    al
         dec    ah
         ret
subrot   endp

codigo   ends

; a diretiva a seguir indica o fim do codigo fonte (ultima linha do arquivo)
; e informa que o programa deve começar a execucao no rotulo "inicio"
         end    inicio 

