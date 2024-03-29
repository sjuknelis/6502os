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
	.export		_create_new_element
	.export		_mainloop
	.import		_krectangle
	.import		_kreplace
	.import		_ktext
	.export		_first_window_element
	.export		_last_window_element
	.export		_window_x
	.export		_window_y
	.export		_mouse_triggered
	.export		_input_box_index
	.export		_kmalloc_ptr
	.export		_kmalloc
	.export		_moving_window
	.export		_render
	.export		_cinput_buf
	.export		_cinput_buf_write_ptr
	.export		_cinput_buf_read_ptr
	.export		_update_buttons

.segment	"DATA"

_window_x:
	.byte	$00
_window_y:
	.byte	$00
_mouse_triggered:
	.byte	$00
_input_box_index:
	.byte	$00
_kmalloc_ptr:
	.word	$1000
_moving_window:
	.byte	$00
_cinput_buf:
	.word	$7E00
_cinput_buf_write_ptr:
	.word	$7DFF
_cinput_buf_read_ptr:
	.byte	$00

.segment	"BSS"

_first_window_element:
	.res	2,$00
_last_window_element:
	.res	2,$00

; ---------------------------------------------------------------
; struct $anon-struct-0001 *__near__ create_new_element (char size, char new_row, char *text, char is_button, void *action)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_create_new_element: near

.segment	"CODE"

	jsr     pushax
	lda     #$00
	jsr     pusha
	tax
	lda     #$19
	jsr     _kmalloc
	jsr     pushax
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$09
	lda     (sp),y
	ldy     #$00
	sta     (ptr1),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$08
	lda     (sp),y
	ldy     #$01
	sta     (ptr1),y
	jmp     L0004
L0002:	jsr     ldax0sp
	jsr     incax2
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (sp),y
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L0007
	inx
L0007:	sta     sreg
	stx     sreg+1
	ldy     #$07
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (sp),y
	tay
	lda     (ptr1),y
	ldy     #$00
	sta     (sreg),y
	ldy     #$02
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
L0004:	ldy     #$07
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (sp),y
	tay
	lda     (ptr1),y
	bne     L0002
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	lda     #$01
	ldy     #$12
	sta     (ptr1),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$05
	lda     (sp),y
	ldy     #$13
	sta     (ptr1),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$04
	jsr     ldaxysp
	ldy     #$15
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	ldy     #$17
	sta     (ptr1),y
	iny
	sta     (ptr1),y
	lda     _last_window_element
	ora     _last_window_element+1
	bne     L0005
	jsr     ldax0sp
	sta     _first_window_element
	stx     _first_window_element+1
	jmp     L000B
L0005:	lda     _last_window_element+1
	sta     ptr1+1
	lda     _last_window_element
	sta     ptr1
	jsr     ldax0sp
	ldy     #$17
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
L000B:	jsr     ldax0sp
	sta     _last_window_element
	stx     _last_window_element+1
	jsr     ldax0sp
	ldy     #$0A
	jmp     addysp

.endproc

; ---------------------------------------------------------------
; void __near__ mainloop (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_mainloop: near

.segment	"CODE"

L0002:	jsr     _render
	jsr     _update_buttons
	jmp     L0002

.endproc

; ---------------------------------------------------------------
; void *__near__ kmalloc (int size)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_kmalloc: near

.segment	"CODE"

	jsr     pushax
	lda     _kmalloc_ptr
	ldx     _kmalloc_ptr+1
	jsr     pushax
	ldy     #$03
	jsr     ldaxysp
	clc
	adc     _kmalloc_ptr
	sta     _kmalloc_ptr
	txa
	adc     _kmalloc_ptr+1
	sta     _kmalloc_ptr+1
	jsr     ldax0sp
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ render (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_render: near

.segment	"CODE"

	lda     _first_window_element
	ldx     _first_window_element+1
	jsr     pushax
	lda     _window_x
	jsr     pusha
	lda     _window_y
	jsr     pusha
	jmp     L0004
L0008:	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	beq     L0006
	lda     _window_x
	sta     (sp),y
	dey
	clc
	lda     #$0E
	adc     (sp),y
	sta     (sp),y
L0006:	ldy     #$03
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$12
	lda     (ptr1),y
	beq     L0007
	ldy     #$01
	lda     (sp),y
	jsr     pusha
	ldy     #$04
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	jsr     pusha
	ldy     #$02
	lda     (sp),y
	jsr     pusha
	lda     #$0E
	jsr     pusha
	lda     #$07
	jsr     _krectangle
	ldy     #$03
	jsr     ldaxysp
	jsr     incax2
	jsr     pushax
	ldy     #$03
	lda     (sp),y
	jsr     pusha
	ldy     #$03
	lda     (sp),y
	clc
	adc     #$01
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #$07
	jsr     _ktext
	ldy     #$03
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	ldy     #$12
	sta     (ptr1),y
L0007:	ldy     #$03
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	ldy     #$01
	clc
	adc     (sp),y
	sta     (sp),y
	ldy     #$03
	jsr     ldaxysp
	ldy     #$18
	jsr     ldaxidx
	ldy     #$02
	jsr     staxysp
L0004:	ldy     #$02
	lda     (sp),y
	iny
	ora     (sp),y
	jne     L0008
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ update_buttons (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_update_buttons: near

.segment	"CODE"

	lda     _first_window_element
	ldx     _first_window_element+1
	jsr     pushax
	lda     _window_x
	jsr     pusha
	lda     _window_y
	jsr     pusha
	jsr     decsp2
	lda     #$00
	jsr     pusha
	jmp     L0004
L0002:	lda     _cinput_buf
	ldx     _cinput_buf+1
	ldy     _cinput_buf_read_ptr
	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	ldy     #$00
	sta     (sp),y
	inc     _cinput_buf_read_ptr
L0004:	lda     _cinput_buf_write_ptr+1
	sta     ptr1+1
	lda     _cinput_buf_write_ptr
	sta     ptr1
	ldy     #$00
	lda     (ptr1),y
	cmp     _cinput_buf_read_ptr
	bne     L0002
	lda     _moving_window
	jeq     L002A
	lda     (sp),y
	and     #$80
	jeq     L002A
	sty     _moving_window
	lda     $8005
	ldy     #$02
	sta     (sp),y
	lda     $8006
	dey
	sta     (sp),y
	jmp     L000B
L0029:	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	beq     L000D
	lda     _window_x
	ldy     #$04
	sta     (sp),y
	dey
	clc
	lda     #$0E
	adc     (sp),y
	sta     (sp),y
L000D:	ldy     #$04
	lda     (sp),y
	jsr     pusha
	ldy     #$07
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	jsr     pusha
	ldy     #$05
	lda     (sp),y
	jsr     pusha
	lda     #$0E
	jsr     pusha
	lda     #$00
	jsr     _krectangle
	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$01
	ldy     #$12
	sta     (ptr1),y
	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	ldy     #$04
	clc
	adc     (sp),y
	sta     (sp),y
	ldy     #$06
	jsr     ldaxysp
	ldy     #$18
	jsr     ldaxidx
	ldy     #$05
	jsr     staxysp
L000B:	ldy     #$05
	lda     (sp),y
	iny
	ora     (sp),y
	jne     L0029
	lda     _window_x
	jsr     pusha
	lda     #$0A
	jsr     pusha
	ldx     #$00
	lda     _window_y
	ldy     #$0A
	jsr     decaxy
	jsr     pusha
	lda     #$0A
	jsr     pusha
	lda     #$00
	jsr     _krectangle
	ldy     #$02
	lda     (sp),y
	sta     _window_x
	dey
	lda     (sp),y
	sta     _window_y
	jmp     L0013
L002A:	lda     $8005
	ldy     #$04
	cmp     (sp),y
	jcc     L0014
	lda     $8005
	jsr     pusha0
	ldy     #$06
	lda     (sp),y
	ldy     #$0A
	jsr     incaxy
	jsr     tosicmp
	beq     L0025
	jpl     L0014
L0025:	lda     $8006
	jsr     pusha0
	ldy     #$05
	lda     (sp),y
	ldy     #$0A
	jsr     decaxy
	jsr     tosicmp
	jmi     L0014
	lda     $8006
	ldy     #$03
	cmp     (sp),y
	beq     L0024
	jcs     L0014
L0024:	ldy     #$00
	lda     (sp),y
	and     #$80
	jeq     L0014
	lda     #$01
	sta     _moving_window
	jmp     L0013
L002D:	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	beq     L0016
	lda     _window_x
	ldy     #$04
	sta     (sp),y
	dey
	clc
	lda     #$0E
	adc     (sp),y
	sta     (sp),y
L0016:	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$13
	lda     (ptr1),y
	jeq     L0020
	lda     $8005
	ldy     #$04
	cmp     (sp),y
	jcc     L0018
	lda     $8005
	jsr     pusha0
	ldy     #$06
	lda     (sp),y
	sta     sreg
	ldy     #$08
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	clc
	adc     sreg
	bcc     L0023
	inx
L0023:	jsr     tosicmp
	jpl     L0018
	lda     $8006
	ldy     #$03
	cmp     (sp),y
	jcc     L0018
	lda     $8006
	jsr     pusha0
	ldy     #$05
	lda     (sp),y
	ldy     #$0E
	jsr     incaxy
	jsr     tosicmp
	jpl     L0018
	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$14
	lda     (ptr1),y
	bne     L001C
	ldy     #$04
	lda     (sp),y
	jsr     pusha
	ldy     #$07
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	jsr     pusha
	ldy     #$05
	lda     (sp),y
	jsr     pusha
	lda     #$0E
	jsr     pusha
	lda     #$04
	jsr     pusha
	lda     #$07
	jsr     _kreplace
L001C:	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$01
	ldy     #$14
	sta     (ptr1),y
	ldy     #$00
	lda     (sp),y
	and     #$80
	beq     L0031
	lda     _mouse_triggered
	bne     L002F
	ldy     #$06
	jsr     ldaxysp
	ldy     #$16
	jsr     pushwidx
	ldy     #$08
	jsr     ldaxysp
	jsr     incax2
	pha
	ldy     #$00
	lda     (sp),y
	sta     jmpvec+1
	iny
	lda     (sp),y
	sta     jmpvec+2
	pla
	jsr     jmpvec
	jsr     incsp2
	jsr     _render
L002F:	lda     #$01
	sta     _mouse_triggered
	jmp     L0020
L0031:	sta     _mouse_triggered
	jmp     L0020
L0018:	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$14
	lda     (ptr1),y
	beq     L0021
	ldy     #$04
	lda     (sp),y
	jsr     pusha
	ldy     #$07
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	jsr     pusha
	ldy     #$05
	lda     (sp),y
	jsr     pusha
	lda     #$0E
	jsr     pusha
	lda     #$07
	jsr     pusha
	lda     #$04
	jsr     _kreplace
L0021:	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	ldy     #$14
	sta     (ptr1),y
L0020:	ldy     #$06
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	jsr     mulax9
	ldy     #$04
	clc
	adc     (sp),y
	sta     (sp),y
	ldy     #$06
	jsr     ldaxysp
	ldy     #$18
	jsr     ldaxidx
	ldy     #$05
	jsr     staxysp
L0014:	ldy     #$05
	lda     (sp),y
	iny
	ora     (sp),y
	jne     L002D
L0013:	jmp     incsp7

.endproc

