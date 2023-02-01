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
	.export		_first
	.export		_init_malloc
	.export		_malloc
	.export		_merge_empties
	.export		_free

.segment	"DATA"

_first:
	.word	$1000

; ---------------------------------------------------------------
; void __near__ init_malloc (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_init_malloc: near

.segment	"CODE"

	lda     _first+1
	sta     ptr1+1
	lda     _first
	sta     ptr1
	lda     #$00
	tay
	sta     (ptr1),y
	lda     _first+1
	sta     ptr1+1
	lda     _first
	sta     ptr1
	tya
	iny
	sta     (ptr1),y
	iny
	lda     #$10
	sta     (ptr1),y
	lda     _first+1
	sta     ptr1+1
	lda     _first
	sta     ptr1
	lda     #$00
	iny
	sta     (ptr1),y
	iny
	sta     (ptr1),y
	lda     _first+1
	sta     ptr1+1
	lda     _first
	sta     ptr1
	lda     #$00
	iny
	sta     (ptr1),y
	iny
	sta     (ptr1),y
	rts

.endproc

; ---------------------------------------------------------------
; char *__near__ malloc (int size)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_malloc: near

.segment	"CODE"

	jsr     pushax
	lda     _first
	ldx     _first+1
	jsr     pushax
	jsr     decsp2
	jmp     L0004
L000E:	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	bne     L0006
	ldy     #$03
	jsr     ldaxysp
	ldy     #$02
	jsr     ldaxidx
	ldy     #$04
	cmp     (sp),y
	txa
	iny
	sbc     (sp),y
	bvs     L000D
	eor     #$80
L000D:	bmi     L0003
L0006:	ldy     #$03
	jsr     ldaxysp
	ldy     #$06
	jsr     ldaxidx
	ldy     #$02
	jsr     staxysp
L0004:	ldy     #$02
	lda     (sp),y
	iny
	ora     (sp),y
	bne     L000E
L0003:	ldy     #$02
	lda     (sp),y
	iny
	ora     (sp),y
	jeq     L000A
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$01
	ldy     #$00
	sta     (ptr1),y
	ldy     #$03
	jsr     ldaxysp
	ldy     #$02
	jsr     ldaxidx
	sec
	ldy     #$04
	sbc     (sp),y
	pha
	txa
	iny
	sbc     (sp),y
	tax
	pla
	cmp     #$08
	txa
	sbc     #$00
	jcc     L000C
	ldy     #$03
	jsr     ldaxysp
	jsr     incax7
	sta     ptr1
	stx     ptr1+1
	ldy     #$05
	jsr     ldaxysp
	clc
	adc     ptr1
	pha
	txa
	adc     ptr1+1
	tax
	pla
	jsr     stax0sp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
	jsr     ldax0sp
	sta     sreg
	stx     sreg+1
	ldy     #$03
	jsr     ldaxysp
	ldy     #$02
	jsr     ldaxidx
	sec
	ldy     #$04
	sbc     (sp),y
	pha
	txa
	iny
	sbc     (sp),y
	tax
	pla
	jsr     decax7
	ldy     #$01
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$03
	jsr     ldaxysp
	ldy     #$03
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jsr     ldax0sp
	sta     sreg
	stx     sreg+1
	ldy     #$03
	jsr     ldaxysp
	ldy     #$06
	jsr     ldaxidx
	ldy     #$05
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	sta     ptr1
	stx     ptr1+1
	jsr     ldax0sp
	ldy     #$03
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	dey
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	jsr     ldax0sp
	ldy     #$05
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	ldy     #$03
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$05
	jsr     ldaxysp
	ldy     #$01
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
L000C:	ldy     #$03
	jsr     ldaxysp
	jsr     incax1
	jmp     L0001
L000A:	tax
L0001:	jmp     incsp6

.endproc

; ---------------------------------------------------------------
; void __near__ merge_empties (struct $anon-struct-0001 *first)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_merge_empties: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	ldy     #$06
	jsr     pushwidx
	jsr     ldax0sp
	ldy     #$06
	jsr     pushwidx
	ldy     #$05
	jsr     ldaxysp
	sta     ptr2
	stx     ptr2+1
	ldy     #$02
	jsr     ldaxidx
	sta     sreg
	stx     sreg+1
	ldy     #$03
	jsr     ldaxysp
	ldy     #$02
	jsr     ldaxidx
	jsr     incax7
	clc
	adc     sreg
	pha
	txa
	adc     sreg+1
	tax
	pla
	ldy     #$01
	sta     (ptr2),y
	iny
	txa
	sta     (ptr2),y
	ldy     #$05
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	jsr     ldax0sp
	ldy     #$05
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$05
	jsr     ldaxysp
	ldy     #$03
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jmp     incsp6

.endproc

; ---------------------------------------------------------------
; void __near__ free (char *ptr)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_free: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	ldy     #$31
	jsr     decaxy
	jsr     pushax
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
	jsr     ldax0sp
	ldy     #$03
	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	iny
	ora     (ptr1),y
	beq     L0002
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	bne     L0002
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     stax0sp
	jsr     _merge_empties
L0002:	jsr     ldax0sp
	ldy     #$05
	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	iny
	ora     (ptr1),y
	beq     L0006
	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	bne     L0006
	jsr     ldax0sp
	jsr     _merge_empties
L0006:	jmp     incsp4

.endproc

