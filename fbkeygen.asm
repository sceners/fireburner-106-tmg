; Fireburner v1.06 Keygen - can be done this way...
; Features: uneccessary floating point operations, linear algo, Byte-Flag-Check.
; Summery: This is what we call a *lame* Protection...boring :-(
; How to find ? -> Procdump 1.6 -> Unpack -> UPX -> fireburner.exe -> W32Dasm -> string search for "(Registered)"
; That's all. Even a blind can see that it's a simple one-byte flag-check which decides if regged or not
; Set some bpm w on the address where the flag appears and restart...

.DATA
fmat		db "%lu",0
userinput	db 260 dup(0)
userkey		db 20 dup(0)
.CODE
	...
	shr	eax, 1				; length of username / 2
	mov	esi, eax
	push	1
	pop	eax
	xor	ebx, ebx
	mov	edx, esi
	test	edx, edx
	jz	@@isz
@@l1:	movzx	ecx, byte ptr userinput[eax-1]
	lea	edi, [eax+64h]
	xor	ecx, edi
	add	ebx, ecx	
	inc	eax
	dec	edx
	jnz	@@l1	

@@isz:	imul	eax, ebx, 224196		; eax=ebx*(13Ah*2CAh)
	shr	eax, 1				; /2
	lea	eax, [eax*2+eax]		; *3

	mov	tempvar, eax

	lea	edx, [esi+1]
	mov	eax, nlen
	sub	edx, eax
	dec	edx
	xor	ebx, ebx
@@l2:	movzx	ecx, byte ptr userinput[eax-1]
	lea	esi, [eax+64h]
	xor	ecx, esi
	add	ebx, ecx
	dec	eax
	inc	edx
	jnz	@@l2	
	
	imul	eax, ebx, 2CAh
	mov	ebx, eax
	imul	eax, ebx, 13Ah
	shr	eax, 1
	lea	eax, [eax+eax*2]

	add	eax, tempvar
	js	@@toobig			; if serial signed, username is too long

	lea	edi, userkey
	call	_wsprintfA, edi, offset fmat, eax
	add	esp, 12
	and	byte ptr[edi+eax], 0
