.import   __RAM_START__,__RAM_SIZE__
.import    copydata,zerobss,initlib,donelib
.include  "zeropage.inc"

.export   _nmi_int
.export		_init_task_internal,_continue_task

INIT_VECTOR_LO = $7ff0
INIT_VECTOR_HI = $7ff1
SP_STORE = $7ff2
NMI_DETECT = $7ff3

MEMORY_BANK = $8004
TRANSFER_REG = $800C

.segment	"CODE"

.proc	_init_task_internal: near

.segment	"CODE"
  ; Sets up a task to be continued
  ; Specify init vector in 7ff0/1 and pass mb as argument

  ; Save kernel stack pointer
  tsx
  stx SP_STORE

  ; Go to task mb with init vector in x/y
  ldx INIT_VECTOR_LO
  ldy INIT_VECTOR_HI
  sta MEMORY_BANK

  ; Set up init vector and flags on stack
  stx $01fe
  sty $01ff
  lda #%00100100
  sta $01fd

  ; Set up dummy register values
  lda #$00
  pha
  pha
  pha

  ; Set up stack pointer
  ldx #$f9
  txs
  stx SP_STORE

  ; Do C initialization
  lda #<(__RAM_START__ + __RAM_SIZE__)
  sta sp
  lda #>(__RAM_START__ + __RAM_SIZE__)
  sta sp+1

  jsr zerobss
  jsr copydata
  jsr initlib

  ; Go to mb 0
  lda #$00
  sta MEMORY_BANK

  ; Load kernel stack pointer
  ldx SP_STORE
  txs

  rts

.endproc

.segment	"CODE"

.proc	_continue_task: near

.segment	"CODE"
  ; Continues execution of task in designated mb
  ; Pass mb as argument

  ; Save kernel stack pointer
  tsx
  stx SP_STORE

  ; Go to task mb
  sta MEMORY_BANK

  ; Load task stack pointer
  ldx SP_STORE
  txs

  ; Indicate syscall processing
  lda #$00
  sta $7f00

  ; Load task registers
  pla
  tay
  pla
  tax
  pla

  ; Return from NMI/init_task
  rti

.endproc

.segment "STARTUP"

_nmi_int:
  ; Check if in mb 0 and continue if no
  pha
  lda MEMORY_BANK
  bne go_to_0

  ; Reset NMI detect and return
  lda #$00
  sta NMI_DETECT
  pla
  rti

go_to_0:
  ; Save task registers
  txa
  pha
  tya
  pha

  ; Save task stack pointer
  tsx
  stx SP_STORE

  ; Copy $7f00-7fef from task to kernel
  ; Copied four bytes at a time using TRANSFER_REG
  ; X always stores task mb, Y stores index
  ldx MEMORY_BANK
  ldy #$00
copy_data:
  ; Go to task mb
  stx MEMORY_BANK

  ; Read in four bytes
  lda $7f00,y
  sta TRANSFER_REG
  iny
  lda $7f00,y
  sta TRANSFER_REG + 1
  iny
  lda $7f00,y
  sta TRANSFER_REG + 2
  iny
  lda $7f00,y
  sta TRANSFER_REG + 3
  dey
  dey
  dey
  
  ; Go to mb 0
  lda #$00
  sta MEMORY_BANK

  ; Write out four bytes
  lda TRANSFER_REG
  sta $7f00,y
  iny
  lda TRANSFER_REG + 1
  sta $7f00,y
  iny
  lda TRANSFER_REG + 2
  sta $7f00,y
  iny
  lda TRANSFER_REG + 3
  sta $7f00,y
  iny

  ; Loop if not done
  cpy #$f0
  bne copy_data

  ; Load kernel stack pointer
  ldx SP_STORE
  txs

  ; Reset NMI detect
  lda #$00
  sta NMI_DETECT

  ; Return from continue_task
  rts