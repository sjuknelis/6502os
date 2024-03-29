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
	.forceimport	__STARTUP__
	.import		_set_keyboard_handler
	.import		_create_new_element
	.import		_mainloop
	.import		_ksprint
	.import		_ksprint_hex
	.import		_find
	.import		_open
	.import		_read
	.import		_memcpy
	.import		_strlen
	.export		_first_line
	.export		_last_line
	.export		_last_line_index
	.export		_keypress
	.export		_save
	.export		_main

.segment	"RODATA"

S0002:
	.byte	$74,$65,$73,$74,$00
S0003:
	.byte	$53,$61,$76,$65,$00
S0004	:=	S0002+0
S0005:
	.byte	$2D,$2D,$2D,$0A,$00
S0001	:=	S0002+4

.segment	"BSS"

_first_line:
	.res	2,$00
_last_line:
	.res	2,$00
_last_line_index:
	.res	1,$00

; ---------------------------------------------------------------
; void __near__ keypress (char s)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_keypress: near

.segment	"CODE"

	jsr     pusha
	lda     _first_line
	ldx     _first_line+1
	jsr     pushax
	jsr     decsp2
	ldy     #$04
	lda     (sp),y
	cmp     #$08
	bne     L0014
	lda     _last_line_index
	beq     L0007
	lda     _last_line
	ldx     _last_line+1
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	dec     _last_line_index
	lda     _last_line_index
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L000E
	inx
L000E:	sta     ptr1
	stx     ptr1+1
	lda     #$00
	jmp     L001E
L0005:	ldy     #$03
	jsr     ldaxysp
	jsr     stax0sp
	ldy     #$03
	jsr     ldaxysp
	ldy     #$18
	jsr     ldaxidx
	ldy     #$02
	jsr     staxysp
L0007:	ldy     #$03
	jsr     ldaxysp
	cpx     _last_line+1
	bne     L0005
	cmp     _last_line
	bne     L0005
	jsr     ldax0sp
	sta     _last_line
	stx     _last_line+1
	jsr     incax2
	jsr     _strlen
	sta     _last_line_index
	jmp     L000D
L0014:	lda     (sp),y
	cmp     #$0D
	bne     L0015
	lda     _last_line
	ldx     _last_line+1
	ldy     #$17
	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	iny
	ora     (ptr1),y
	beq     L000A
	lda     _last_line
	ldx     _last_line+1
	jsr     ldaxidx
	jmp     L0017
L000A:	lda     #$14
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(S0001)
	ldx     #>(S0001)
	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	jsr     _create_new_element
L0017:	sta     _last_line
	stx     _last_line+1
	lda     #$00
	sta     _last_line_index
	jmp     L000D
L0015:	lda     _last_line_index
	cmp     #$14
	bcs     L000D
	lda     _last_line
	ldx     _last_line+1
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	lda     _last_line_index
	inc     _last_line_index
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L0010
	inx
L0010:	sta     ptr1
	stx     ptr1+1
	lda     (sp),y
L001E:	ldy     #$00
	sta     (ptr1),y
	lda     _last_line+1
	sta     ptr1+1
	lda     _last_line
	sta     ptr1
	lda     #$01
	ldy     #$12
	sta     (ptr1),y
L000D:	jmp     incsp5

.endproc

; ---------------------------------------------------------------
; void __near__ save (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_save: near

.segment	"CODE"

	lda     sp
	sec
	sta     sp
	lda     sp+1
	sbc     #$01
	sta     sp+1
	lda     _first_line
	ldx     _first_line+1
	jsr     pushax
	lda     #$00
	jsr     pusha
	jsr     pusha
	jmp     L0007
L0005:	lda     #$04
	jsr     leaa0sp
	ldy     #$01
	clc
	adc     (sp),y
	bcc     L000B
	inx
L000B:	sta     sreg
	stx     sreg+1
	ldy     #$03
	jsr     ldaxysp
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	ldy     #$00
	sta     (sreg),y
	iny
	clc
	tya
	adc     (sp),y
	sta     (sp),y
	dey
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
L0007:	ldy     #$00
	lda     (sp),y
	cmp     #$14
	bcs     L0010
	ldy     #$03
	jsr     ldaxysp
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	bne     L0005
L0010:	lda     #$04
	jsr     leaa0sp
	ldy     #$01
	sta     ptr1
	stx     ptr1+1
	lda     (sp),y
	tay
	lda     #$0A
	sta     (ptr1),y
	ldy     #$01
	clc
	tya
	adc     (sp),y
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	ldy     #$03
	jsr     ldaxysp
	cpx     _last_line+1
	bne     L0013
	cmp     _last_line
	beq     L0003
L0013:	ldy     #$03
	jsr     ldaxysp
	ldy     #$18
	jsr     ldaxidx
	ldy     #$02
	jsr     staxysp
	jmp     L0007
L0003:	lda     #$04
	jsr     leaa0sp
	ldy     #$01
	sta     ptr1
	stx     ptr1+1
	lda     (sp),y
	tay
	lda     #$00
	sta     (ptr1),y
	lda     #$04
	jsr     leaa0sp
	jsr     _ksprint
	ldx     #$60
	lda     #$00
	jsr     pushax
	lda     #$06
	jsr     leaa0sp
	jsr     pushax
	ldx     #$01
	lda     #$00
	jsr     _memcpy
	lda     #$03
	sta     $800A
	lda     #$04
	clc
	adc     sp
	lda     #$01
	adc     sp+1
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

	lda     sp
	sec
	sbc     #$15
	sta     sp
	lda     sp+1
	sbc     #$01
	sta     sp+1
	jsr     push0
	jsr     pusha
	jsr     decsp2
	lda     #$0A
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0002)
	ldx     #>(S0002)
	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	jsr     _create_new_element
	lda     #$0A
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0003)
	ldx     #>(S0003)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_save)
	ldx     #>(_save)
	jsr     _create_new_element
	lda     #<(S0004)
	ldx     #>(S0004)
	jsr     _find
	jsr     _open
	lda     #$1A
	jsr     leaa0sp
	jsr     pushax
	ldx     #$01
	lda     #$00
	jsr     _read
	lda     #<(S0005)
	ldx     #>(S0005)
	jsr     _ksprint
	jmp     L0004
L0002:	ldy     #$04
	jsr     ldaxysp
	ldy     #$1A
	jsr     incaxy
	jsr     leaaxsp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     _ksprint_hex
	ldy     #$04
	jsr     ldaxysp
	ldy     #$1A
	jsr     incaxy
	jsr     leaaxsp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	cmp     #$0A
	bne     L0005
	lda     #$05
	jsr     leaa0sp
	ldy     #$02
	sta     ptr1
	stx     ptr1+1
	lda     (sp),y
	tay
	lda     #$00
	sta     (ptr1),y
	lda     #$14
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     leaa0sp
	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	jsr     _create_new_element
	jsr     stax0sp
	lda     _first_line
	ora     _first_line+1
	bne     L0007
	jsr     ldax0sp
	sta     _first_line
	stx     _first_line+1
L0007:	lda     #$00
	ldy     #$02
	jmp     L000C
L0005:	ldy     #$02
	lda     (sp),y
	cmp     #$14
	bcs     L0009
	lda     #$05
	jsr     leaa0sp
	clc
	adc     (sp),y
	bcc     L000A
	inx
L000A:	jsr     pushax
	ldy     #$06
	jsr     ldaxysp
	ldy     #$1C
	jsr     incaxy
	jsr     leaaxsp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     staspidx
	ldy     #$02
	clc
	lda     #$01
	adc     (sp),y
L000C:	sta     (sp),y
L0009:	iny
	ldx     #$00
	lda     #$01
	jsr     addeqysp
L0004:	ldy     #$04
	jsr     ldaxysp
	ldy     #$1A
	jsr     incaxy
	jsr     leaaxsp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jne     L0002
	lda     #$05
	jsr     leaa0sp
	ldy     #$02
	sta     ptr1
	stx     ptr1+1
	lda     (sp),y
	tay
	lda     #$00
	sta     (ptr1),y
	lda     #$14
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     leaa0sp
	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	jsr     _create_new_element
	sta     _last_line
	stx     _last_line+1
	ldy     #$02
	lda     (sp),y
	sta     _last_line_index
	lda     #<(_keypress)
	ldx     #>(_keypress)
	jsr     _set_keyboard_handler
	jsr     _mainloop
	lda     #$1A
	clc
	adc     sp
	lda     #$01
	adc     sp+1
	rts

.endproc

