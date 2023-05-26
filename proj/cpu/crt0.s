; Startup code for cc65 (Single Board Computer version)

.export   _init, _exit, _irq_int
.import   _main, _nmi_int

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import   __RAM_START__, __RAM_SIZE__       ; Linker generated

.import    copydata, zerobss, initlib, donelib

.include  "zeropage.inc"

.segment  "STARTUP"

_irq_int:
  ; Serial print X
  lda #88
  sta $8003
  jmp _irq_int

_init:
  ; Serial print J
  lda #74
  sta $8003

  ; Initialize stack pointer to $01FF
  ldx #$ff
  txs

  ; Clear decimal mode
  cld                     

  ; Set cc65 argument stack pointer
  lda #<(__RAM_START__ + __RAM_SIZE__)
  sta sp
  lda #>(__RAM_START__ + __RAM_SIZE__)
  sta sp + 1

  ; Initialize memory storage
  jsr zerobss   ; Clear BSS segment
  jsr copydata  ; Initialize DATA segment
  jsr initlib   ; Run constructors

  ; Call main()
  jsr _main

_exit:
  ; Back from main (this is also the _exit entry)
  jsr donelib
  brk

.segment  "VECTORS"

.addr _nmi_int  ; NMI vector
.addr _init     ; Reset vector
.addr _irq_int  ; IRQ/BRK vector