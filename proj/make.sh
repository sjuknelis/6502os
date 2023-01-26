cc65 -t none -O --cpu 6502 main.c &&
cc65 -t none -O --cpu 6502 drivers/graphics.c &&
cc65 -t none -O --cpu 6502 drivers/serial.c &&
cc65 -t none -O --cpu 6502 stdlib/malloc.c &&
cc65 -t none -O --cpu 6502 stdlib/syscall.c &&
cc65 -t none -O --cpu 6502 tasks/tasks.c &&
ca65 --cpu 6502 main.s &&
ca65 --cpu 6502 cpu/crt0.s &&
ca65 --cpu 6502 drivers/graphics.s &&
ca65 --cpu 6502 drivers/serial.s &&
ca65 --cpu 6502 stdlib/malloc.s &&
ca65 --cpu 6502 stdlib/syscall.s &&
ca65 --cpu 6502 tasks/context.s &&
ca65 --cpu 6502 tasks/tasks.s &&
ld65 -C cpu/sbc.cfg -m main.map \
  main.o \
  cpu/crt0.o \
  drivers/graphics.o \
  drivers/serial.o \
  stdlib/malloc.o \
  stdlib/syscall.o \
  tasks/context.o \
  tasks/tasks.o \
  cpu/sbc.lib \
  &&
cp a.out ../emu/a.out &&
cd ../emu &&
python main.py $1 $2 $3