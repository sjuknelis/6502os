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
	.export		_strcmp
	.export		_memset

; ---------------------------------------------------------------
; int __near__ strcmp (char *stra, char *strb)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_strcmp: near

.segment	"CODE"

	jsr     pushax
	lda     #$00
	jsr     pusha
	jmp     L0004
L0002:	ldy     #$04
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	sta     sreg
	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     sreg
	beq     L0007
	ldy     #$04
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	jsr     pusha0
	ldy     #$04
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (sp),y
	tay
	lda     (ptr1),y
	jsr     tossuba0
	jmp     L0001
L0007:	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
L0004:	ldy     #$04
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	bne     L0002
	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	bne     L0002
	tax
L0001:	jmp     incsp5

.endproc

; ---------------------------------------------------------------
; void __near__ memset (char *mem, char value, char size)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_memset: near

.segment	"CODE"

	jsr     pusha
	lda     #$00
	jsr     pusha
	tay
L0007:	lda     (sp),y
	iny
	cmp     (sp),y
	bcs     L0003
	lda     (sp),y
	clc
	ldy     #$03
	adc     (sp),y
	sta     ptr1
	lda     #$00
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$02
	lda     (sp),y
	ldy     #$00
	sta     (ptr1),y
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
	jmp     L0007
L0003:	jmp     incsp5

.endproc

