cc65 -t none -O --cpu 6502 main.c &&
cc65 -t none -O --cpu 6502 drivers/fs.c &&
cc65 -t none -O --cpu 6502 drivers/graphics.c &&
cc65 -t none -O --cpu 6502 drivers/serial.c &&
cc65 -t none -O --cpu 6502 runnable/calculator.c &&
cc65 -t none -O --cpu 6502 runnable/explorer.c &&
cc65 -t none -O --cpu 6502 runnable/shell.c &&
cc65 -t none -O --cpu 6502 stdlib/malloc.c &&
cc65 -t none -O --cpu 6502 stdlib/mem.c &&
cc65 -t none -O --cpu 6502 stdlib/syscall.c &&
cc65 -t none -O --cpu 6502 stdlib/window.c &&
cc65 -t none -O --cpu 6502 tasks/tasks.c &&
ca65 --cpu 6502 main.s &&
ca65 --cpu 6502 cpu/crt0.s &&
ca65 --cpu 6502 drivers/exec_entry.s &&
ca65 --cpu 6502 drivers/fs.s &&
ca65 --cpu 6502 drivers/graphics.s &&
ca65 --cpu 6502 drivers/serial.s &&
ca65 --cpu 6502 runnable/calculator.s &&
ca65 --cpu 6502 runnable/explorer.s &&
ca65 --cpu 6502 runnable/shell.s &&
ca65 --cpu 6502 stdlib/malloc.s &&
ca65 --cpu 6502 stdlib/mem.s &&
ca65 --cpu 6502 stdlib/syscall.s &&
ca65 --cpu 6502 stdlib/window.s &&
ca65 --cpu 6502 tasks/context.s &&
ca65 --cpu 6502 tasks/tasks.s &&
ld65 -C cpu/sbc.cfg -m main.map \
  main.o \
  cpu/crt0.o \
  drivers/exec_entry.o \
  drivers/fs.o \
  drivers/graphics.o \
  drivers/serial.o \
  runnable/calculator.o \
  runnable/explorer.o \
  runnable/shell.o \
  stdlib/malloc.o \
  stdlib/mem.o \
  stdlib/syscall.o \
  stdlib/window.o \
  tasks/context.o \
  tasks/tasks.o \
  cpu/sbc.lib \
  &&
cp a.out ../emu/a.out &&
cd ../emu &&
python3 main.py $1 $2 $3