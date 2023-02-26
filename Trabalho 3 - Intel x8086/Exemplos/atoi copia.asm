String1	db	"100",0
String2	db	"4096",0
String3	db	"65535",0
		
		; ax = atoi(String1)
		lea		bx,String1
		call	atoi

		.exit


atoi	proc near ;Converte uma string (BX) para um numero inteiro (AX)

	; A = 0;
	mov		ax, 0
		
    Loop_atoi:
	    ; while (*S!='\0') {
	    cmp		byte ptr[bx], 0 ;Verifica se o caractere atual eh um \0, se nao for, continua
	    jz		end_atoi ;Se chegar no final da string, pula para o final da subrotina

	    mov		cx, 10
	    mul		cx

	    mov		ch, 0
	    mov		cl, [bx]
	    add		ax, cx

	    sub		ax, '0'

	    ;Incrementa a posicao atual da string
	    inc		bx

        ;Volta para o inicio, em loop
	    jmp		Loop_atoi

end_atoi:
		ret
atoi	endp
