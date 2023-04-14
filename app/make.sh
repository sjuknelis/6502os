cc65 -t none -O --cpu 6502 code/main.c &&
ca65 --cpu 6502 code/main.s &&
ca65 --cpu 6502 cpu/crt0.s &&
ld65 -C cpu/sbc.cfg -m main.map \
  code/main.o \
  cpu/crt0.o \
  cpu/sbc.lib \