; use este arquivo para praticar a sequencia de operacoes para montar, ligar e executar um programa
; no ambiente MS-DOS (commando prompt do Windows ou DOSBox)

; associacao de registradores de segmento com definicoes de segmento
			ASSUME CS:CODIGO,SS:PILHA,DS:DADOS

; definicao do segmento de pilha
PILHA		SEGMENT	STACK
			DB 32 DUP ('STACK---')
PILHA		ENDS

; definicao do segmento de dados
DADOS		SEGMENT
MENSAGEM	DB 'Hello World !',0DH,0AH
TAMANHO	EQU $-MENSAGEM
CONTADOR	DB ?
DADOS		ENDS

; definicao do segmento de codigo
CODIGO		SEGMENT
START:		MOV AX,DADOS		; Inicializa segmento de dados
			MOV DS,AX
			MOV CONTADOR, 1
DE_NOVO: 	CALL FRASE
			DEC CONTADOR
			JNZ DE_NOVO

; retorna o controle do processador para o DOS
			MOV AH, 4CH		
			INT 21H

; definicao de uma subrotina
FRASE		PROC NEAR
			MOV BX,0001H
			LEA DX, MENSAGEM
			MOV CX, TAMANHO
			MOV AH,40H
			INT 21H			; Escreve mensagem
                RET
FRASE		ENDP

CODIGO		ENDS
			END START ; execucao comeca por START:
