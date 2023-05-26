.include  "zeropage.inc"

.export   _exec_entry

ENTRY_VECTOR = $3000

.segment	"CODE"

.proc	_exec_entry: near

.segment	"CODE"
  jmp (ENTRY_VECTOR)

.endproc
