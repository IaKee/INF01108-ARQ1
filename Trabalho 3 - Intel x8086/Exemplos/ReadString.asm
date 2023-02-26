;
;====================================================================
; ReadString
;	- Escrever uma rotina para ler um string do teclado
;	- O ponteiro para o string entra em DS:BX
;	- O número máximo de caracteres a serem lidos (e colocados
;		no buffer do string) entra em CX
;	- Deve considerar o CR (0x0D) como final da entrada do string
;	- Deve processar BS (back space), código ASCII 0x08
;	- Quando chegar ao final do string, ignorar qualquer nova 
;		tecla digitada
;	- Um string é uma seqüência de caracteres ASCII que termina
;		com 00H (‘\0’)
;====================================================================
;
		.model	small
		.stack

		.data
BufferTec	db	100 dup (?)

		.code
		.startup

		; Chamada da rotina (para teste)
		
		;ReadString(bx=BufferTec, cx=10)	// limita em 10 caracteres
		mov		cx,10
		lea		bx,BufferTec
		call	ReadString
		
		.exit


;
;--------------------------------------------------------------------
;Função: Lê um string do teclado
;Entra: (S) -> DS:BX -> Ponteiro para o string
;	    (M) -> CX -> numero maximo de caracteres aceitos
;Algoritmo:
;	Pos = 0
;	while(1) {
;		al = Int21(7)	// Espera pelo teclado
;		if (al==CR) {
;			*S = '\0'
;			return
;		}
;		if (al==BS) {
;			if (Pos==0) continue;
;			Print (BS, SPACE, BS)	// Coloca 3 caracteres na tela
;			--S
;			++M
;			--Pos
;		}
;		if (M==0) continue
;		if (al>=SPACE) {
;			*S = al
;			++S
;			--M
;			++Pos
;			Int21 (s, AL)	// Coloca AL na tela
;		}
;	}
;--------------------------------------------------------------------
ReadString	proc	near

		;Pos = 0
		mov		dx,0

RDSTR_1:
		;while(1) {
		;	al = Int21(7)		// Espera pelo teclado
		mov		ah,7
		int		21H

		;	if (al==CR) {
		cmp		al,0DH
		jne		RDSTR_A

		;		*S = '\0'
		mov		byte ptr[bx],0
		;		return
		ret
		;	}

RDSTR_A:
		;	if (al==BS) {
		cmp		al,08H
		jne		RDSTR_B

		;		if (Pos==0) continue;
		cmp		dx,0
		jz		RDSTR_1

		;		Print (BS, SPACE, BS)
		push	dx
		
		mov		dl,08H
		mov		ah,2
		int		21H
		
		mov		dl,' '
		mov		ah,2
		int		21H
		
		mov		dl,08H
		mov		ah,2
		int		21H
		
		pop		dx

		;		--s
		dec		bx
		;		++M
		inc		cx
		;		--Pos
		dec		dx
		
		;	}
		jmp		RDSTR_1

RDSTR_B:
		;	if (M==0) continue
		cmp		cx,0
		je		RDSTR_1

		;	if (al>=SPACE) {
		cmp		al,' '
		jl		RDSTR_1

		;		*S = al
		mov		[bx],al

		;		++S
		inc		bx
		;		--M
		dec		cx
		;		++Pos
		inc		dx

		;		Int21 (s, AL)
		push	dx
		mov		dl,al
		mov		ah,2
		int		21H
		pop		dx

		;	}
		;}
		jmp		RDSTR_1

ReadString	endp

;--------------------------------------------------------------------
		end
;--------------------------------------------------------------------
