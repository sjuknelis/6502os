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
	.export		_krectangle
	.export		_kbitmap
	.export		_kprint
	.export		_kclear
	.export		_hline
	.export		_letters
	.export		_kprint_row
	.export		_kprint_col
	.export		_kprint_end_per_line

.segment	"DATA"

_letters:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$36
	.byte	$36
	.byte	$36
	.byte	$36
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$66
	.byte	$66
	.byte	$FF
	.byte	$66
	.byte	$66
	.byte	$FF
	.byte	$66
	.byte	$66
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$7E
	.byte	$FF
	.byte	$1B
	.byte	$1F
	.byte	$7E
	.byte	$F8
	.byte	$D8
	.byte	$FF
	.byte	$7E
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$0E
	.byte	$1B
	.byte	$DB
	.byte	$6E
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$76
	.byte	$DB
	.byte	$D8
	.byte	$70
	.byte	$00
	.byte	$00
	.byte	$7F
	.byte	$C6
	.byte	$CF
	.byte	$D8
	.byte	$70
	.byte	$70
	.byte	$D8
	.byte	$CC
	.byte	$CC
	.byte	$6C
	.byte	$38
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$1C
	.byte	$0C
	.byte	$0E
	.byte	$00
	.byte	$00
	.byte	$0C
	.byte	$18
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$18
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$99
	.byte	$5A
	.byte	$3C
	.byte	$FF
	.byte	$3C
	.byte	$5A
	.byte	$99
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$FF
	.byte	$FF
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$18
	.byte	$1C
	.byte	$1C
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$38
	.byte	$38
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$60
	.byte	$60
	.byte	$30
	.byte	$30
	.byte	$18
	.byte	$18
	.byte	$0C
	.byte	$0C
	.byte	$06
	.byte	$06
	.byte	$03
	.byte	$03
	.byte	$00
	.byte	$00
	.byte	$3C
	.byte	$66
	.byte	$C3
	.byte	$E3
	.byte	$F3
	.byte	$DB
	.byte	$CF
	.byte	$C7
	.byte	$C3
	.byte	$66
	.byte	$3C
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$78
	.byte	$38
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$C0
	.byte	$C0
	.byte	$60
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$03
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$03
	.byte	$03
	.byte	$07
	.byte	$7E
	.byte	$07
	.byte	$03
	.byte	$03
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$FF
	.byte	$CC
	.byte	$6C
	.byte	$3C
	.byte	$1C
	.byte	$0C
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$03
	.byte	$03
	.byte	$07
	.byte	$FE
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$FE
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$E7
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$7F
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$38
	.byte	$38
	.byte	$00
	.byte	$00
	.byte	$38
	.byte	$38
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$18
	.byte	$1C
	.byte	$1C
	.byte	$00
	.byte	$00
	.byte	$1C
	.byte	$1C
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$06
	.byte	$0C
	.byte	$18
	.byte	$30
	.byte	$60
	.byte	$C0
	.byte	$60
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$FF
	.byte	$00
	.byte	$FF
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$60
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$03
	.byte	$06
	.byte	$0C
	.byte	$18
	.byte	$30
	.byte	$60
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$03
	.byte	$C3
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$3F
	.byte	$60
	.byte	$CF
	.byte	$DB
	.byte	$D3
	.byte	$DD
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$FF
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$66
	.byte	$3C
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$FE
	.byte	$C7
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$FE
	.byte	$C7
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$FC
	.byte	$CE
	.byte	$C7
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$CE
	.byte	$FC
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FC
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FC
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$CF
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$FF
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$7C
	.byte	$EE
	.byte	$C6
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$06
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C6
	.byte	$CC
	.byte	$D8
	.byte	$F0
	.byte	$E0
	.byte	$F0
	.byte	$D8
	.byte	$CC
	.byte	$C6
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$DB
	.byte	$FF
	.byte	$FF
	.byte	$E7
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$C7
	.byte	$C7
	.byte	$CF
	.byte	$CF
	.byte	$DF
	.byte	$DB
	.byte	$FB
	.byte	$F3
	.byte	$F3
	.byte	$E3
	.byte	$E3
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FE
	.byte	$C7
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$3F
	.byte	$6E
	.byte	$DF
	.byte	$DB
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$66
	.byte	$3C
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C6
	.byte	$CC
	.byte	$D8
	.byte	$F0
	.byte	$FE
	.byte	$C7
	.byte	$C3
	.byte	$C3
	.byte	$C7
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$03
	.byte	$03
	.byte	$07
	.byte	$7E
	.byte	$E0
	.byte	$C0
	.byte	$C0
	.byte	$E7
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$E7
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$3C
	.byte	$3C
	.byte	$66
	.byte	$66
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$E7
	.byte	$FF
	.byte	$FF
	.byte	$DB
	.byte	$DB
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$66
	.byte	$66
	.byte	$3C
	.byte	$3C
	.byte	$18
	.byte	$3C
	.byte	$3C
	.byte	$66
	.byte	$66
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$3C
	.byte	$3C
	.byte	$66
	.byte	$66
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$C0
	.byte	$C0
	.byte	$60
	.byte	$30
	.byte	$7E
	.byte	$0C
	.byte	$06
	.byte	$03
	.byte	$03
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$3C
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$3C
	.byte	$00
	.byte	$03
	.byte	$03
	.byte	$06
	.byte	$06
	.byte	$0C
	.byte	$0C
	.byte	$18
	.byte	$18
	.byte	$30
	.byte	$30
	.byte	$60
	.byte	$60
	.byte	$00
	.byte	$00
	.byte	$3C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$3C
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$66
	.byte	$3C
	.byte	$18
	.byte	$FF
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$38
	.byte	$30
	.byte	$70
	.byte	$00
	.byte	$00
	.byte	$7F
	.byte	$C3
	.byte	$C3
	.byte	$7F
	.byte	$03
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$FE
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$FE
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$C3
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$7F
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$7F
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$00
	.byte	$00
	.byte	$7F
	.byte	$C0
	.byte	$C0
	.byte	$FE
	.byte	$C3
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$FC
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$33
	.byte	$1E
	.byte	$7E
	.byte	$C3
	.byte	$03
	.byte	$03
	.byte	$7F
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$7E
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$FE
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$00
	.byte	$38
	.byte	$6C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$0C
	.byte	$00
	.byte	$00
	.byte	$0C
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C6
	.byte	$CC
	.byte	$F8
	.byte	$F0
	.byte	$D8
	.byte	$CC
	.byte	$C6
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$78
	.byte	$00
	.byte	$00
	.byte	$DB
	.byte	$DB
	.byte	$DB
	.byte	$DB
	.byte	$DB
	.byte	$DB
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$FC
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$7C
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$7C
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$FE
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$03
	.byte	$03
	.byte	$03
	.byte	$7F
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$7F
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$C0
	.byte	$E0
	.byte	$FE
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$FE
	.byte	$03
	.byte	$03
	.byte	$7E
	.byte	$C0
	.byte	$C0
	.byte	$7F
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$1C
	.byte	$36
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$FC
	.byte	$30
	.byte	$30
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$7E
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$C6
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$3C
	.byte	$3C
	.byte	$66
	.byte	$66
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$E7
	.byte	$FF
	.byte	$DB
	.byte	$C3
	.byte	$C3
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C3
	.byte	$66
	.byte	$3C
	.byte	$18
	.byte	$3C
	.byte	$66
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$C0
	.byte	$60
	.byte	$60
	.byte	$30
	.byte	$18
	.byte	$3C
	.byte	$66
	.byte	$66
	.byte	$C3
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$FF
	.byte	$60
	.byte	$30
	.byte	$18
	.byte	$0C
	.byte	$06
	.byte	$FF
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$0F
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$38
	.byte	$F0
	.byte	$38
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$0F
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$00
	.byte	$00
	.byte	$F0
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$1C
	.byte	$0F
	.byte	$1C
	.byte	$18
	.byte	$18
	.byte	$18
	.byte	$F0
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$06
	.byte	$8F
	.byte	$F1
	.byte	$60
	.byte	$00
	.byte	$00
	.byte	$00
_kprint_row:
	.byte	$00
_kprint_col:
	.byte	$00
_kprint_end_per_line:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00

; ---------------------------------------------------------------
; void __near__ krectangle (char x, char w, char y, char h, char color)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_krectangle: near

.segment	"CODE"

	jsr     pusha
	jsr     decsp1
	ldy     #$03
	lda     (sp),y
	ldy     #$00
L0007:	sta     (sp),y
	lda     (sp),y
	jsr     pusha0
	ldy     #$04
	lda     (sp),y
	clc
	iny
	adc     (sp),y
	bcc     L0006
	inx
L0006:	jsr     tosicmp
	bpl     L0003
	ldy     #$05
	lda     (sp),y
	jsr     pusha
	ldy     #$05
	lda     (sp),y
	jsr     pusha
	ldy     #$02
	lda     (sp),y
	jsr     pusha
	ldy     #$04
	lda     (sp),y
	jsr     _hline
	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	jmp     L0007
L0003:	jmp     incsp6

.endproc

; ---------------------------------------------------------------
; void __near__ kbitmap (char *bitmap, char x, char y, char w, char h, char color0, char color1)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_kbitmap: near

.segment	"CODE"

	jsr     pusha
	jsr     decsp5
	ldy     #$08
	lda     (sp),y
	jsr     pusha0
	ldy     #$09
	lda     (sp),y
	jsr     tosumula0
	jsr     pushax
	lda     #$08
	jsr     tosdiva0
	sec
	sbc     #$01
	jsr     pusha
	lda     #$07
	jsr     pusha
	ldy     #$0B
	lda     (sp),y
	ldy     #$05
L0023:	sta     (sp),y
	lda     (sp),y
	jsr     pusha0
	ldy     #$0B
	lda     (sp),y
	clc
	ldy     #$0D
	adc     (sp),y
	bcc     L001D
	inx
L001D:	jsr     tosicmp
	jpl     L0003
	ldy     #$05
	lda     (sp),y
	lsr     a
	sta     $8001
	ldy     #$0C
	lda     (sp),y
	lsr     a
	ldy     #$06
	sta     (sp),y
	dey
	lda     (sp),y
	and     #$01
	cmp     #$01
	bne     L0024
	iny
	clc
	lda     #$80
	adc     (sp),y
	sta     (sp),y
L0024:	lda     #$00
	ldy     #$02
	sta     (sp),y
	ldy     #$0C
	lda     (sp),y
	and     #$01
	cmp     #$01
	bne     L0008
	ldy     #$06
	lda     (sp),y
	sta     $8000
	ldy     #$0E
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (sp),y
	tay
	ldx     #$00
	lda     (ptr1),y
	sta     ptr1
	lda     (sp,x)
	tay
	lda     ptr1
	jsr     asraxy
	and     #$01
	stx     tmp1
	ora     tmp1
	php
	ldy     #$00
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	plp
	beq     L0025
	lda     $8002
	and     #$F0
	sta     ptr1
	ldy     #$07
	jmp     L0031
L0025:	lda     $8002
	and     #$F0
	sta     ptr1
	ldy     #$08
L0031:	lda     (sp),y
	ora     ptr1
	sta     $8002
	lda     (sp,x)
	cmp     #$FF
	bne     L000C
	ldy     #$01
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	lda     #$07
	dey
	sta     (sp),y
L000C:	ldy     #$06
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
	lda     #$01
	ldy     #$02
L0021:	sta     (sp),y
L0008:	ldy     #$02
	lda     (sp),y
	jsr     pusha0
	ldy     #$0C
	lda     (sp),y
	jsr     decax1
	jsr     tosicmp
	jpl     L000E
	ldy     #$06
	lda     (sp),y
	sta     $8000
	ldy     #$0E
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (sp),y
	tay
	ldx     #$00
	lda     (ptr1),y
	sta     ptr1
	lda     (sp,x)
	tay
	lda     ptr1
	jsr     asraxy
	and     #$01
	stx     tmp1
	ora     tmp1
	php
	ldy     #$00
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	plp
	beq     L0011
	ldy     #$07
	jmp     L002C
L0011:	ldy     #$08
L002C:	lda     (sp),y
	ldy     #$04
	sta     (sp),y
	lda     (sp,x)
	cmp     #$FF
	bne     L0013
	ldy     #$01
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	lda     #$07
	dey
	sta     (sp),y
L0013:	ldy     #$0E
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (sp),y
	tay
	ldx     #$00
	lda     (ptr1),y
	sta     ptr1
	lda     (sp,x)
	tay
	lda     ptr1
	jsr     asraxy
	and     #$01
	stx     tmp1
	ora     tmp1
	php
	ldy     #$00
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	plp
	beq     L0014
	ldy     #$07
	jmp     L002D
L0014:	ldy     #$08
L002D:	lda     (sp),y
	ldy     #$03
	sta     (sp),y
	lda     (sp,x)
	cmp     #$FF
	bne     L0016
	ldy     #$01
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	lda     #$07
	dey
	sta     (sp),y
L0016:	ldy     #$04
	lda     (sp),y
	asl     a
	asl     a
	asl     a
	asl     a
	sta     ptr1
	dey
	lda     (sp),y
	ora     ptr1
	sta     $8002
	ldy     #$06
	clc
	lda     #$01
	adc     (sp),y
	sta     (sp),y
	ldy     #$02
	clc
	tya
	adc     (sp),y
	jmp     L0021
L000E:	ldy     #$0C
	lda     (sp),y
	and     #$01
	cmp     #$01
	jsr     booleq
	sta     ptr1
	ldy     #$0A
	lda     (sp),y
	and     #$01
	cmp     #$01
	jsr     booleq
	eor     ptr1
	beq     L0004
	ldy     #$06
	lda     (sp),y
	sta     $8000
	ldy     #$0E
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (sp),y
	tay
	ldx     #$00
	lda     (ptr1),y
	sta     ptr1
	lda     (sp,x)
	tay
	lda     ptr1
	jsr     asraxy
	and     #$01
	stx     tmp1
	ora     tmp1
	php
	ldy     #$00
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	plp
	beq     L0026
	lda     $8002
	and     #$0F
	sta     ptr1
	ldy     #$07
	jmp     L0036
L0026:	lda     $8002
	and     #$0F
	sta     ptr1
	ldy     #$08
L0036:	lda     (sp),y
	asl     a
	asl     a
	asl     a
	asl     a
	ora     ptr1
	sta     $8002
	lda     (sp,x)
	cmp     #$FF
	bne     L0004
	ldy     #$01
	lda     (sp),y
	sec
	sbc     #$01
	sta     (sp),y
	lda     #$07
	dey
	sta     (sp),y
L0004:	ldy     #$05
	clc
	lda     #$01
	adc     (sp),y
	jmp     L0023
L0003:	ldy     #$0F
	jmp     addysp

.endproc

; ---------------------------------------------------------------
; void __near__ kprint (char *str)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_kprint: near

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
	cmp     #$08
	beq     L0007
	cmp     #$0A
	jeq     L000B
	cmp     #$0D
	jeq     L000B
	jmp     L000D
L0007:	lda     #<(_letters)
	ldx     #>(_letters)
	jsr     pushax
	ldx     #$00
	lda     _kprint_col
	jsr     mulax9
	jsr     pusha
	lda     _kprint_row
	jsr     pusha0
	lda     #$0E
	jsr     tosumula0
	jsr     pusha
	lda     #$08
	jsr     pusha
	lda     #$0D
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     _kbitmap
	dec     _kprint_col
	lda     _kprint_col
	cmp     #$FF
	bne     L0008
	dec     _kprint_row
	ldy     _kprint_row
	lda     _kprint_end_per_line,y
	sta     _kprint_col
L0008:	lda     #<(_letters+819)
	ldx     #>(_letters+819)
	jsr     pushax
	ldx     #$00
	lda     _kprint_col
	jsr     mulax9
	jsr     pusha
	lda     _kprint_row
	jsr     pusha0
	lda     #$0E
	jsr     tosumula0
	jsr     pusha
	lda     #$08
	jsr     pusha
	lda     #$0D
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     _kbitmap
	lda     #<(_kprint_end_per_line)
	ldx     #>(_kprint_end_per_line)
	clc
	adc     _kprint_row
	bcc     L000A
	inx
L000A:	sta     ptr1
	stx     ptr1+1
	lda     _kprint_col
	sec
	sbc     #$01
	ldy     #$00
	sta     (ptr1),y
	jmp     L0012
L000B:	lda     #<(_letters)
	ldx     #>(_letters)
	jsr     pushax
	ldx     #$00
	lda     _kprint_col
	jsr     mulax9
	jsr     pusha
	lda     _kprint_row
	jsr     pusha0
	lda     #$0E
	jsr     tosumula0
	jsr     pusha
	lda     #$08
	jsr     pusha
	lda     #$0D
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     _kbitmap
	inc     _kprint_row
	lda     #$00
	sta     _kprint_col
	lda     #<(_letters+819)
	ldx     #>(_letters+819)
	jsr     pushax
	lda     #$00
	jmp     L0020
L000D:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (sp),y
	tay
	ldx     #$00
	lda     (ptr1),y
	ldy     #$20
	jsr     decaxy
	jsr     pushax
	lda     #$0D
	jsr     tosmula0
	clc
	adc     #<(_letters)
	tay
	txa
	adc     #>(_letters)
	tax
	tya
	jsr     pushax
	ldx     #$00
	lda     _kprint_col
	jsr     mulax9
	jsr     pusha
	lda     _kprint_row
	jsr     pusha0
	lda     #$0E
	jsr     tosumula0
	jsr     pusha
	lda     #$08
	jsr     pusha
	lda     #$0D
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     _kbitmap
	inc     _kprint_col
	lda     #<(_kprint_end_per_line)
	ldx     #>(_kprint_end_per_line)
	clc
	adc     _kprint_row
	bcc     L000E
	inx
L000E:	sta     ptr1
	stx     ptr1+1
	lda     _kprint_col
	sec
	sbc     #$01
	ldy     #$00
	sta     (ptr1),y
	lda     _kprint_col
	cmp     #$1C
	bcc     L000F
	inc     _kprint_row
	sty     _kprint_col
L000F:	lda     #<(_letters+819)
	ldx     #>(_letters+819)
	jsr     pushax
	ldx     #$00
	lda     _kprint_col
	jsr     mulax9
L0020:	jsr     pusha
	lda     _kprint_row
	jsr     pusha0
	lda     #$0E
	jsr     tosumula0
	jsr     pusha
	lda     #$08
	jsr     pusha
	lda     #$0D
	jsr     pusha
	lda     #$01
	jsr     pusha
	lda     #$07
	jsr     _kbitmap
	ldy     #$00
L0012:	clc
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
	jne     L0002
	jmp     incsp3

.endproc

; ---------------------------------------------------------------
; void __near__ kclear (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_kclear: near

.segment	"CODE"

	jsr     decsp2
	ldy     #$01
L0002:	lda     M0001,y
	sta     (sp),y
	dey
	bpl     L0002
	lda     #$00
	jsr     pusha
	lda     #$FF
	jsr     pusha
	lda     #$00
	jsr     pusha
	lda     #$FF
	jsr     pusha
	lda     #$01
	jsr     _krectangle
	lda     #$00
	sta     _kprint_row
	lda     #$01
	sta     _kprint_col
	lda     sp
	ldx     sp+1
	jsr     _kprint
	jmp     incsp2

.segment	"RODATA"

M0001:
	.byte	$08
	.byte	$00

.endproc

; ---------------------------------------------------------------
; void __near__ hline (char x, char w, char y, char color)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_hline: near

.segment	"CODE"

	jsr     pusha
	ldy     #$00
	lda     (sp),y
	asl     a
	asl     a
	asl     a
	asl     a
	sta     ptr1
	lda     (sp),y
	ora     ptr1
	jsr     pusha
	ldy     #$04
	lda     (sp),y
	lsr     a
	jsr     pusha
	lda     #$00
	jsr     pusha
	ldy     #$04
	lda     (sp),y
	lsr     a
	sta     $8001
	lda     (sp),y
	and     #$01
	cmp     #$01
	bne     L0002
	tay
	clc
	lda     #$80
	adc     (sp),y
	sta     (sp),y
L0002:	ldy     #$06
	lda     (sp),y
	and     #$01
	cmp     #$01
	bne     L0004
	tay
	lda     (sp),y
	sta     $8000
	lda     $8002
	and     #$F0
	sta     ptr1
	ldy     #$03
	lda     (sp),y
	ora     ptr1
	sta     $8002
	ldy     #$01
	clc
	tya
	adc     (sp),y
	sta     (sp),y
	tya
	dey
L000D:	sta     (sp),y
L0004:	ldx     #$00
	lda     (sp,x)
	jsr     pusha0
	ldy     #$07
	lda     (sp),y
	jsr     decax1
	jsr     tosicmp
	bpl     L0007
	ldy     #$01
	lda     (sp),y
	sta     $8000
	iny
	lda     (sp),y
	sta     $8002
	dey
	clc
	tya
	adc     (sp),y
	sta     (sp),y
	dey
	clc
	lda     #$02
	adc     (sp),y
	jmp     L000D
L0007:	ldy     #$06
	lda     (sp),y
	and     #$01
	cmp     #$01
	jsr     booleq
	sta     ptr1
	dey
	lda     (sp),y
	and     #$01
	cmp     #$01
	jsr     booleq
	eor     ptr1
	beq     L000A
	ldy     #$01
	lda     (sp),y
	sta     $8000
	lda     $8002
	and     #$0F
	sta     ptr1
	ldy     #$03
	lda     (sp),y
	asl     a
	asl     a
	asl     a
	asl     a
	ora     ptr1
	sta     $8002
L000A:	jmp     incsp7

.endproc

