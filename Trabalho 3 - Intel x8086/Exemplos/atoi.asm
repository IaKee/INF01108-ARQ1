;
;====================================================================
; atoi
;	- Escrever uma rotina para converter um string em um número
;		de 16 bits
;	- O ponteiro para o string entra em DS:BX
;	- O resultado (com 16 bits) deve ser retornado em AX
;	- Um string é uma seqüência de caracteres ASCII que termina
;		com 00H (‘\0’)
;====================================================================
;
		.model small
		.stack

		.data
String1	db	"100",0
String2	db	"4096",0
String3	db	"65535",0

		.code
		.startup

		; Chamada da rotina (para teste)
		
		; ax = atoi(String1)
		lea		bx,String1
		call	atoi

		lea		bx,String2
		call	atoi

		lea		bx,String3
		call	atoi

		.exit


;
;--------------------------------------------------------------------
;Função:Converte um ASCII-DECIMAL para HEXA
;Entra: (S) -> DS:BX -> Ponteiro para o string de origem
;Sai:	(A) -> AX -> Valor "Hex" resultante
;Algoritmo:
;	A = 0;
;	while (*S!='\0') {
;		A = 10 * A + (*S - '0')
;		++S;
;	}
;	return
;--------------------------------------------------------------------
atoi	proc near

		; A = 0;
		mov		ax,0
		
atoi_2:
		; while (*S!='\0') {
		cmp		byte ptr[bx], 0
		jz		atoi_1

		; 	A = 10 * A
		mov		cx,10
		mul		cx

		; 	A = A + *S
		mov		ch,0
		mov		cl,[bx]
		add		ax,cx

		; 	A = A - '0'
		sub		ax,'0'

		; 	++S
		inc		bx
		
		;}
		jmp		atoi_2

atoi_1:
		; return
		ret

atoi	endp

;--------------------------------------------------------------------
		end
;--------------------------------------------------------------------
