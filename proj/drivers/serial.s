;
; File generated by cc65 v 2.19 - N/A
;
	.fopt		compiler,"cc65 v 2.19 - N/A"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.export		_ksprint
	.export		_hex
	.export		_ksprint_hex

.segment	"DATA"

_hex:
	.addr	S0001

.segment	"RODATA"

S0001:
	.byte	$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$61,$62,$63,$64,$65,$66
	.byte	$00

; ---------------------------------------------------------------
; void __near__ ksprint (char *str)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_ksprint: near

.segment	"CODE"

	jsr     pushax
	lda     #$00
	jsr     pusha
	jmp     L0004
L0002:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	sta     $8003
	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
L0004:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	bne     L0002
	jmp     incsp3

.endproc

; ---------------------------------------------------------------
; void __near__ ksprint_hex (int value)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_ksprint_hex: near

.segment	"CODE"

	jsr     pushax
	lda     #$30
	sta     $8003
	lda     #$78
	sta     $8003
	jsr     ldax0sp
	txa
	and     #$F0
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	clc
	adc     _hex
	ldx     _hex+1
	bcc     L0003
	inx
L0003:	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	sta     $8003
	jsr     ldax0sp
	txa
	and     #$0F
	tax
	txa
	cpx     #$80
	ldx     #$00
	bcc     L0006
	dex
	clc
L0006:	adc     _hex
	sta     ptr1
	txa
	adc     _hex+1
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	sta     $8003
	lda     (sp),y
	and     #$F0
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	clc
	adc     _hex
	ldx     _hex+1
	bcc     L0004
	inx
L0004:	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	sta     $8003
	lda     (sp),y
	and     #$0F
	clc
	adc     _hex
	ldx     _hex+1
	bcc     L0005
	inx
L0005:	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	sta     $8003
	lda     #$0A
	sta     $8003
	jmp     incsp2

.endproc

