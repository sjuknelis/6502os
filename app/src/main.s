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
	.import		_create_new_element
	.import		_mainloop
	.import		_memset
	.import		_inttostr
	.export		_screen
	.export		_screen_index
	.export		_add_number
	.export		_button_0
	.export		_button_1
	.export		_button_2
	.export		_button_3
	.export		_button_4
	.export		_button_5
	.export		_button_6
	.export		_button_7
	.export		_button_8
	.export		_button_9
	.export		_button_plus
	.export		_button_minus
	.export		_button_times
	.export		_button_slash
	.export		_evaluate
	.export		_main

.segment	"DATA"

_screen_index:
	.byte	$00

.segment	"RODATA"

S000E:
	.byte	$20,$20,$20,$20,$30,$20,$20,$20,$20,$20,$00
S0003:
	.byte	$20,$20,$38,$20,$20,$00
S0004:
	.byte	$20,$20,$37,$20,$20,$00
S0005:
	.byte	$20,$20,$3D,$20,$20,$00
S0006:
	.byte	$20,$20,$36,$20,$20,$00
S0007:
	.byte	$20,$20,$35,$20,$20,$00
S0008:
	.byte	$20,$20,$34,$20,$20,$00
S0009:
	.byte	$20,$20,$2F,$20,$20,$00
S000A:
	.byte	$20,$20,$33,$20,$20,$00
S000B:
	.byte	$20,$20,$32,$20,$20,$00
S000C:
	.byte	$20,$20,$31,$20,$20,$00
S000D:
	.byte	$20,$20,$2A,$20,$20,$00
S0002:
	.byte	$20,$20,$39,$20,$20,$00
S000F:
	.byte	$20,$20,$2B,$20,$20,$00
S0010:
	.byte	$20,$20,$2D,$20,$20,$00
S0001	:=	S000E+10

.segment	"BSS"

_screen:
	.res	2,$00

; ---------------------------------------------------------------
; void __near__ add_number (char number)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_add_number: near

.segment	"CODE"

	jsr     pusha
	lda     _screen
	ldx     _screen+1
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	ldy     _screen_index
	sta     (ptr1),y
	lda     _screen+1
	sta     ptr1+1
	lda     _screen
	sta     ptr1
	lda     #$01
	ldy     #$12
	sta     (ptr1),y
	inc     _screen_index
	jmp     incsp1

.endproc

; ---------------------------------------------------------------
; void __near__ button_0 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_0: near

.segment	"CODE"

	lda     #$30
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_1 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_1: near

.segment	"CODE"

	lda     #$31
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_2 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_2: near

.segment	"CODE"

	lda     #$32
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_3 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_3: near

.segment	"CODE"

	lda     #$33
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_4 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_4: near

.segment	"CODE"

	lda     #$34
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_5 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_5: near

.segment	"CODE"

	lda     #$35
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_6 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_6: near

.segment	"CODE"

	lda     #$36
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_7 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_7: near

.segment	"CODE"

	lda     #$37
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_8 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_8: near

.segment	"CODE"

	lda     #$38
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_9 (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_9: near

.segment	"CODE"

	lda     #$39
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_plus (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_plus: near

.segment	"CODE"

	lda     #$2B
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_minus (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_minus: near

.segment	"CODE"

	lda     #$2D
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_times (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_times: near

.segment	"CODE"

	lda     #$2A
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ button_slash (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_button_slash: near

.segment	"CODE"

	lda     #$2F
	jmp     _add_number

.endproc

; ---------------------------------------------------------------
; void __near__ evaluate (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_evaluate: near

.segment	"CODE"

	lda     _screen
	ldx     _screen+1
	jsr     incax2
	jsr     pushax
	jsr     push0
	jsr     push0
	jsr     decsp2
	lda     #$00
	jsr     pusha
	jsr     pusha
	jmp     L0004
L0002:	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$2B
	beq     L0016
	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$2D
	beq     L0016
	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$2A
	beq     L0016
	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$2F
	bne     L0005
L0016:	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	ldy     #$01
	sta     (sp),y
	jmp     L000A
L0005:	ldy     #$01
	lda     (sp),y
	bne     L0009
	ldy     #$07
	jsr     ldaxysp
	jsr     mulax10
	sta     ptr2
	stx     ptr2+1
	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	clc
	adc     ptr2
	ldx     ptr2+1
	bcc     L0011
	inx
L0011:	ldy     #$30
	jsr     decaxy
	ldy     #$06
	jmp     L0014
L0009:	ldy     #$05
	jsr     ldaxysp
	jsr     mulax10
	sta     ptr2
	stx     ptr2+1
	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	clc
	adc     ptr2
	ldx     ptr2+1
	bcc     L0012
	inx
L0012:	ldy     #$30
	jsr     decaxy
	ldy     #$04
L0014:	jsr     staxysp
L000A:	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
L0004:	ldy     #$09
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	jne     L0002
	ldy     #$01
	lda     (sp),y
	cmp     #$2A
	beq     L000F
	cmp     #$2B
	beq     L000D
	cmp     #$2D
	beq     L000E
	cmp     #$2F
	beq     L0010
	jmp     L000C
L000D:	ldy     #$05
	jsr     ldaxysp
	clc
	ldy     #$06
	adc     (sp),y
	pha
	txa
	iny
	adc     (sp),y
	tax
	pla
	jmp     L0017
L000E:	ldy     #$07
	jsr     ldaxysp
	sec
	ldy     #$04
	sbc     (sp),y
	pha
	txa
	iny
	sbc     (sp),y
	tax
	pla
	jmp     L0017
L000F:	ldy     #$09
	jsr     pushwysp
	ldy     #$07
	jsr     ldaxysp
	jsr     tosmulax
	jmp     L0017
L0010:	ldy     #$09
	jsr     pushwysp
	ldy     #$07
	jsr     ldaxysp
	jsr     tosdivax
L0017:	ldy     #$02
	jsr     staxysp
L000C:	lda     _screen
	ldx     _screen+1
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	ldy     #$0F
L0013:	sta     (ptr1),y
	dey
	bpl     L0013
	ldy     #$05
	jsr     pushwysp
	lda     _screen
	ldx     _screen+1
	jsr     incax2
	jsr     _inttostr
	sta     _screen_index
	lda     _screen+1
	sta     ptr1+1
	lda     _screen
	sta     ptr1
	lda     #$01
	ldy     #$12
	sta     (ptr1),y
	ldy     #$0A
	jmp     addysp

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

	lda     #$0C
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0001)
	ldx     #>(S0001)
	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	jsr     _create_new_element
	sta     _screen
	stx     _screen+1
	lda     #$05
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(S0002)
	ldx     #>(S0002)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_9)
	ldx     #>(_button_9)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0003)
	ldx     #>(S0003)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_8)
	ldx     #>(_button_8)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0004)
	ldx     #>(S0004)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_7)
	ldx     #>(_button_7)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0005)
	ldx     #>(S0005)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_evaluate)
	ldx     #>(_evaluate)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(S0006)
	ldx     #>(S0006)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_6)
	ldx     #>(_button_6)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0007)
	ldx     #>(S0007)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_5)
	ldx     #>(_button_5)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0008)
	ldx     #>(S0008)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_4)
	ldx     #>(_button_4)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0009)
	ldx     #>(S0009)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_slash)
	ldx     #>(_button_slash)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(S000A)
	ldx     #>(S000A)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_3)
	ldx     #>(_button_3)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S000B)
	ldx     #>(S000B)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_2)
	ldx     #>(_button_2)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S000C)
	ldx     #>(S000C)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_1)
	ldx     #>(_button_1)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S000D)
	ldx     #>(S000D)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_times)
	ldx     #>(_button_times)
	jsr     _create_new_element
	lda     #$0A
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(S000E)
	ldx     #>(S000E)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_0)
	ldx     #>(_button_0)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S000F)
	ldx     #>(S000F)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_plus)
	ldx     #>(_button_plus)
	jsr     _create_new_element
	lda     #$05
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #<(S0010)
	ldx     #>(S0010)
	jsr     pushax
	lda     #$01
	jsr     pusha
	lda     #<(_button_minus)
	ldx     #>(_button_minus)
	jsr     _create_new_element
	jmp     _mainloop

.endproc

