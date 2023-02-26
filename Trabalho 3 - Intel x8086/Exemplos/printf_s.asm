;
;====================================================================
; printf("%s", string)
; printf("...")
;	- Escrever uma rotina para colocar o conteúdo de um string na tela
;	- O ponteiro para o string entra em DS:BX
;	- Um string é uma seqüência de caracteres ASCII que termina com 00H (‘\0’)
;====================================================================
;
		.model small
		.stack
		
CR		equ		13
LF		equ		10
		
		.data
Texto1	db		"Texto numero 1",CR,LF,0
Texto2	db		"Hello World",CR,LF,0

		.code
		.startup
	
		; printf("Texto numero 1\r\n")
		lea		bx,Texto1
		call	printf_s

		; printf("Hello World\r\n")
		lea		bx,Texto2
		call	printf_s
		
		.exit


;
;--------------------------------------------------------------------
;Função: Escrever um string na tela
;
;void printf_s(char *s -> BX) {
;	While (*s!='\0') {
;		putchar(*s)
; 		++s;
;	}
;}
;--------------------------------------------------------------------
printf_s	proc	near

;	While (*s!='\0') {
	mov		dl,[bx]
	cmp		dl,0
	je		ps_1

;		putchar(*s)
	push	bx
	mov		ah,2
	int		21H
	pop		bx

;		++s;
	inc		bx
		
;	}
	jmp		printf_s
		
ps_1:
	ret
	
printf_s	endp


;--------------------------------------------------------------------
		end
;--------------------------------------------------------------------
