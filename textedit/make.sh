cc65 -t none -O --cpu 6502 src/main.c &&
cc65 -t none -O --cpu 6502 stdlib/fs.c &&
cc65 -t none -O --cpu 6502 stdlib/graphics.c &&
cc65 -t none -O --cpu 6502 stdlib/mem.c &&
cc65 -t none -O --cpu 6502 stdlib/serial.c &&
cc65 -t none -O --cpu 6502 stdlib/window.c &&
ca65 --cpu 6502 src/main.s &&
ca65 --cpu 6502 stdlib/fs.s &&
ca65 --cpu 6502 stdlib/graphics.s &&
ca65 --cpu 6502 stdlib/mem.s &&
ca65 --cpu 6502 stdlib/serial.s &&
ca65 --cpu 6502 stdlib/window.s &&
ca65 --cpu 6502 cpu/crt0.s &&
ld65 -C cpu/sbc.cfg -m main.map \
  src/main.o \
  stdlib/fs.o \
  stdlib/graphics.o \
  stdlib/mem.o \
  stdlib/serial.o \
  stdlib/window.o \
  cpu/crt0.o \
  cpu/sbc.lib \