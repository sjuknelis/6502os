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
	.import		_init_task_internal
	.import		_continue_task
	.import		_krectangle
	.import		_ksprint_hex
	.import		_yield
	.import		_rectangle
	.import		_sprint_hex
	.import		_sleep
	.export		_flashing
	.export		_flashing_fast
	.export		_tasks
	.export		_init_task
	.export		_process_syscalls
	.export		_run_tasks

.segment	"BSS"

_tasks:
	.res	12,$00

; ---------------------------------------------------------------
; void __near__ flashing (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_flashing: near

.segment	"CODE"

	lda     #$00
	jsr     pusha
L0002:	ldy     #$00
	lda     (sp),y
	clc
	adc     #$01
	and     #$07
	sta     (sp),y
	tya
	jsr     pusha
	lda     #$20
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #$20
	jsr     pusha
	ldy     #$04
	lda     (sp),y
	jsr     _rectangle
	ldx     #$00
	lda     (sp,x)
	jsr     _sprint_hex
	ldx     #$00
	lda     #$1E
	jsr     _sleep
	jsr     _yield
	jmp     L0002

.endproc

; ---------------------------------------------------------------
; void __near__ flashing_fast (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_flashing_fast: near

.segment	"CODE"

	lda     #$00
	jsr     pusha
L0002:	ldy     #$00
	lda     (sp),y
	clc
	adc     #$01
	and     #$07
	sta     (sp),y
	lda     #$80
	jsr     pusha
	lda     #$20
	jsr     pusha
	lda     #$80
	jsr     pusha
	lda     #$20
	jsr     pusha
	ldy     #$04
	lda     (sp),y
	jsr     _rectangle
	ldx     #$00
	lda     (sp,x)
	jsr     _sprint_hex
	ldx     #$00
	lda     #$14
	jsr     _sleep
	jsr     _yield
	jmp     L0002

.endproc

; ---------------------------------------------------------------
; void __near__ init_task (char mb, void *func)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_init_task: near

.segment	"CODE"

	jsr     pushax
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	sta     ptr1
	txa
	adc     #>(_tasks)
	sta     ptr1+1
	lda     #$01
	ldy     #$00
	sta     (ptr1),y
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	sta     ptr1
	txa
	adc     #>(_tasks)
	sta     ptr1+1
	lda     #$00
	dey
	sta     (ptr1),y
	iny
	sta     (ptr1),y
	tay
	lda     (sp),y
	sta     $7FF0
	jsr     ldax0sp
	stx     $7FF1
	ldy     #$02
	lda     (sp),y
	jsr     _init_task_internal
	jmp     incsp3

.endproc

; ---------------------------------------------------------------
; void __near__ process_syscalls (char task)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_process_syscalls: near

.segment	"CODE"

	jsr     pusha
	ldx     #$7F
	lda     #$00
	jsr     pushax
	jsr     pusha
	jmp     L0009
L0002:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$01
	jne     L0005
	ldx     #$00
	lda     (sp,x)
	jsr     incax1
	clc
	ldy     #$01
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     pusha
	ldx     #$00
	ldy     #$01
	lda     (sp),y
	jsr     incax2
	clc
	iny
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     pusha
	ldx     #$00
	ldy     #$02
	lda     (sp),y
	jsr     incax3
	clc
	ldy     #$03
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     pusha
	ldx     #$00
	ldy     #$03
	lda     (sp),y
	jsr     incax4
	clc
	ldy     #$04
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     pusha
	ldx     #$00
	ldy     #$04
	lda     (sp),y
	jsr     incax5
	clc
	ldy     #$05
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     _krectangle
	ldy     #$00
	clc
	lda     #$06
	jmp     L000B
L0005:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$02
	bne     L0007
	ldx     #$00
	lda     (sp,x)
	jsr     incax1
	clc
	ldy     #$01
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	sta     sreg
	ldx     #$00
	lda     (sp),y
	jsr     incax2
	clc
	iny
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	tax
	lda     sreg
	jsr     _ksprint_hex
	jmp     L000E
L0007:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	cmp     #$03
	bne     L0009
	tay
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	sta     ptr2
	txa
	adc     #>(_tasks)
	sta     ptr2+1
	ldx     #$00
	lda     (sp,x)
	jsr     incax1
	clc
	ldy     #$01
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	sta     sreg
	ldx     #$00
	lda     (sp),y
	jsr     incax2
	clc
	iny
	adc     (sp),y
	sta     ptr1
	txa
	iny
	adc     (sp),y
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	tax
	lda     sreg
	iny
	sta     (ptr2),y
	iny
	txa
	sta     (ptr2),y
L000E:	ldy     #$00
	clc
	lda     #$03
L000B:	adc     (sp),y
	sta     (sp),y
L0009:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	lda     (ptr1),y
	jne     L0002
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ run_tasks (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_run_tasks: near

.segment	"CODE"

	jsr     decsp2
	lda     #$00
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #<(_flashing)
	ldx     #>(_flashing)
	jsr     _init_task
L0021:	lda     #$00
	tay
	sta     (sp),y
	lda     #$01
	ldy     #$02
L001F:	sta     (sp),y
	cmp     #$04
	jcs     L0006
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	sta     ptr1
	txa
	clc
	adc     #>(_tasks)
	sta     ptr1+1
	ldy     #<(_tasks)
	lda     (ptr1),y
	jeq     L0007
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	tay
	txa
	adc     #>(_tasks)
	tax
	tya
	ldy     #$02
	jsr     ldaxidx
	cpx     #$00
	bne     L0007
	cmp     #$00
	bne     L0007
	ldy     #$02
	lda     (sp),y
	jsr     _continue_task
	ldy     #$02
	lda     (sp),y
	jsr     _process_syscalls
	lda     #$01
	tay
L001E:	sta     (sp),y
	cmp     #$04
	bcs     L0024
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	tay
	txa
	adc     #>(_tasks)
	tax
	tya
	ldy     #$02
	jsr     ldaxidx
	cpx     #$00
	bne     L0027
	cmp     #$00
	beq     L0010
L0027:	ldy     #$01
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	tay
	txa
	adc     #>(_tasks)
	tax
	tya
	sta     sreg
	stx     sreg+1
	ldy     #$02
	jsr     ldaxidx
	jsr     decax1
	ldy     #$01
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
L0010:	ldy     #$01
	clc
	tya
	adc     (sp),y
	jmp     L001E
L0024:	tya
	dey
	sta     (sp),y
L0007:	ldy     #$02
	clc
	lda     #$01
	adc     (sp),y
	jmp     L001F
L0006:	ldy     #$00
	lda     (sp),y
	jne     L0021
	lda     #$01
	sta     $7FF3
L0025:	lda     $7FF3
	bne     L0025
	lda     #$01
	ldy     #$02
L0020:	sta     (sp),y
	cmp     #$04
	jcs     L0021
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	tay
	txa
	adc     #>(_tasks)
	tax
	tya
	ldy     #$02
	jsr     ldaxidx
	cpx     #$00
	bne     L0028
	cmp     #$00
	beq     L001A
L0028:	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     mulax3
	clc
	adc     #<(_tasks)
	tay
	txa
	adc     #>(_tasks)
	tax
	tya
	sta     sreg
	stx     sreg+1
	ldy     #$02
	jsr     ldaxidx
	jsr     decax1
	ldy     #$01
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
L001A:	ldy     #$02
	clc
	lda     #$01
	adc     (sp),y
	jmp     L0020

.endproc

