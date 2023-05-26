; Startup code for cc65 (Single Board Computer version)

.export   _init, _exit
.import   _main, _nmi_int

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import   __RAM_START__, __RAM_SIZE__       ; Linker generated

.import    copydata, zerobss, initlib, donelib

.include  "zeropage.inc"

.segment  "STARTUP"

_init:
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
  jmp $302d

_exit:
  ; Back from main (this is also the _exit entry)
  jsr donelib
  brk

.segment  "VECTORS"

.addr _init     ; Reset vector