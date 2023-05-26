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
	.export		_readdir
	.export		_exec
	.import		_ksprint
	.import		_ksprint_hex
	.import		_exec_entry
	.import		_strcmp
	.import		_memcpy
	.export		_loaded_page
	.export		_readdir_ptr
	.export		_file_ptrs
	.export		_file_ptr_index
	.export		_file_index
	.export		_load_hdd_page
	.export		_find
	.export		_open
	.export		_read
	.export		_stat

.segment	"DATA"

_loaded_page:
	.byte	$FF
_readdir_ptr:
	.word	$6000

.segment	"RODATA"

S0001:
	.byte	$6C,$6F,$61,$64,$69,$6E,$67,$0A,$00
S0003:
	.byte	$64,$6F,$6E,$65,$0A,$00
S0002:
	.byte	$65,$64,$69,$74,$00

.segment	"BSS"

_file_ptrs:
	.res	16,$00
_file_ptr_index:
	.res	1,$00
_file_index:
	.res	2,$00

; ---------------------------------------------------------------
; struct $anon-struct-0001 *__near__ readdir (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_readdir: near

.segment	"CODE"

	jsr     decsp2
	lda     _loaded_page
	beq     L0002
	ldx     #$00
	txa
	jsr     _load_hdd_page
	ldx     #$60
	lda     #$00
	sta     _readdir_ptr
	stx     _readdir_ptr+1
L0002:	lda     _readdir_ptr
	ldx     _readdir_ptr+1
	jsr     _ksprint_hex
	jmp     L0007
L0003:	lda     #$20
	clc
	adc     _readdir_ptr
	sta     _readdir_ptr
	bcc     L0006
	inc     _readdir_ptr+1
L0006:	lda     _readdir_ptr
	cmp     #$00
	lda     _readdir_ptr+1
	sbc     #$70
	bcc     L0007
	ldx     #$00
	txa
	jmp     L0001
L0007:	lda     _readdir_ptr+1
	sta     ptr1+1
	lda     _readdir_ptr
	sta     ptr1
	ldy     #$00
	lda     (ptr1),y
	beq     L0003
	lda     _readdir_ptr
	ldx     _readdir_ptr+1
	jsr     stax0sp
	lda     #$20
	clc
	adc     _readdir_ptr
	sta     _readdir_ptr
	bcc     L0008
	inc     _readdir_ptr+1
L0008:	jsr     ldax0sp
L0001:	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ exec (char *fname)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_exec: near

.segment	"CODE"

	jsr     pushax
	lda     #<(S0001)
	ldx     #>(S0001)
	jsr     _ksprint
	lda     #<(S0002)
	ldx     #>(S0002)
	jsr     _find
	jsr     _open
	ldx     #$30
	lda     #$00
	jsr     pushax
	jsr     _stat
	jsr     _read
	lda     #<(S0003)
	ldx     #>(S0003)
	jsr     _ksprint
	ldx     #$00
	lda     $3000
	jsr     _ksprint_hex
	ldx     #$00
	lda     $3001
	jsr     _ksprint_hex
	jsr     _exec_entry
L0005:	jmp     L0005

.endproc

; ---------------------------------------------------------------
; void __near__ load_hdd_page (int page)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_load_hdd_page: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	cpx     #$00
	bne     L0004
	cmp     _loaded_page
	beq     L0002
L0004:	ldy     #$00
	lda     (sp),y
	sta     $8008
	lda     (sp),y
	sta     _loaded_page
L0002:	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; struct $anon-struct-0001 *__near__ find (char *name)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_find: near

.segment	"CODE"

	jsr     pushax
	jsr     decsp2
	ldx     #$60
	lda     #$00
	sta     _readdir_ptr
	stx     _readdir_ptr+1
	jmp     L0006
L0009:	jsr     ldaxysp
	jsr     _ksprint_hex
	jsr     pushw0sp
	ldy     #$05
	jsr     ldaxysp
	jsr     _strcmp
	cpx     #$00
	bne     L0006
	cmp     #$00
	bne     L0006
	jsr     ldax0sp
	jmp     L0001
L0006:	jsr     _readdir
	jsr     stax0sp
	ldy     #$00
	lda     (sp),y
	iny
	ora     (sp),y
	bne     L0009
	ldx     #$A1
	lda     #$B2
	jsr     _ksprint_hex
	ldx     #$00
	txa
L0001:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ open (struct $anon-struct-0001 *entry)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_open: near

.segment	"CODE"

	jsr     pushax
	lda     #<(_file_ptrs)
	ldx     #>(_file_ptrs)
	jsr     pushax
	ldy     #$03
	jsr     ldaxysp
	ldy     #$10
	jsr     incaxy
	jsr     pushax
	ldx     #$00
	lda     #$10
	jsr     _memcpy
	lda     #$00
	sta     _file_ptr_index
	sta     _file_index
	sta     _file_index+1
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ read (char *dest, int bytes)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_read: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	clc
	adc     _file_index
	pha
	txa
	adc     _file_index+1
	tax
	pla
	cmp     #$01
	txa
	sbc     #$10
	bvs     L0003
	eor     #$80
L0003:	jpl     L0006
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L0013
	inx
	clc
L0013:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	sta     sreg+1
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L0014
	inx
	clc
L0014:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	txa
	ldx     sreg+1
	jsr     _load_hdd_page
	ldy     #$05
	jsr     pushwysp
	clc
	lda     _file_index
	pha
	lda     #$60
	adc     _file_index+1
	tax
	pla
	jsr     pushax
	lda     #$00
	sec
	sbc     _file_index
	pha
	lda     #$10
	sbc     _file_index+1
	tax
	pla
	jsr     _memcpy
	inc     _file_ptr_index
	lda     #$00
	sta     _file_index
	sta     _file_index+1
	sec
	sbc     _file_index
	pha
	lda     #$10
	sbc     _file_index+1
	tax
	pla
	ldy     #$02
	jsr     addeqysp
	lda     #$00
	sec
	sbc     _file_index
	pha
	lda     #$10
	sbc     _file_index+1
	tax
	pla
	jmp     L001C
L001B:	lda     _file_ptr_index
	asl     a
	bcc     L0015
	ldx     #$01
	clc
L0015:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	sta     sreg+1
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L0016
	inx
	clc
L0016:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	txa
	ldx     sreg+1
	jsr     _load_hdd_page
	ldy     #$05
	jsr     pushwysp
	clc
	lda     _file_index
	pha
	lda     #$60
	adc     _file_index+1
	tax
	pla
	jsr     pushax
	ldx     #$10
	lda     #$00
	jsr     _memcpy
	inc     _file_ptr_index
	lda     #$00
	sta     _file_index
	sta     _file_index+1
	ldy     #$02
	ldx     #$10
	jsr     addeqysp
	ldx     #$10
	lda     #$00
L001C:	jsr     subeq0sp
L0006:	jsr     ldax0sp
	cmp     #$01
	txa
	sbc     #$10
	bvs     L0007
	eor     #$80
L0007:	asl     a
	ldx     #$00
	bcs     L001B
	lda     _file_ptr_index
	asl     a
	bcc     L0017
	inx
	clc
L0017:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	sta     sreg+1
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L0018
	inx
	clc
L0018:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	txa
	ldx     sreg+1
	jsr     _ksprint_hex
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L0019
	inx
	clc
L0019:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	sta     sreg+1
	ldx     #$00
	lda     _file_ptr_index
	asl     a
	bcc     L001A
	inx
	clc
L001A:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	txa
	ldx     sreg+1
	jsr     _load_hdd_page
	ldy     #$05
	jsr     pushwysp
	clc
	lda     _file_index
	pha
	lda     #$60
	adc     _file_index+1
	tax
	pla
	jsr     pushax
	ldy     #$05
	jsr     ldaxysp
	jsr     _memcpy
	jsr     ldax0sp
	clc
	adc     _file_index
	sta     _file_index
	txa
	adc     _file_index+1
	sta     _file_index+1
	cmp     #$10
	bne     L0008
	lda     _file_index
	bne     L0008
	inc     _file_ptr_index
	sta     _file_index
	sta     _file_index+1
L0008:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; int __near__ stat (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_stat: near

.segment	"CODE"

	lda     #$00
	jsr     pusha
	tay
L000B:	lda     (sp),y
	cmp     #$08
	bcs     L000D
	ldx     #$00
	lda     (sp),y
	asl     a
	bcc     L0009
	inx
	clc
L0009:	adc     #<(_file_ptrs)
	tay
	txa
	adc     #>(_file_ptrs)
	tax
	tya
	jsr     ldaxi
	cpx     #$00
	bne     L000E
	cmp     #$00
	beq     L0003
L000E:	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
	jmp     L000B
L0003:	tay
L000D:	lda     (sp),y
	tax
	tya
	jsr     aslax4
	jmp     incsp1

.endproc

