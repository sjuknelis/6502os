# Info Doc

Note: In standard 6502 notation, $ signifies a hexadecimal number.

## 0. How to run

Run `python main.py` in the emu folder.

## 1. About the 6502 CPU

The 6502 CPU has a 16-bit address bus and an 8-bit data bus. Whenever the CPU wants to read what exists at a certain address, it actively puts the address onto the address bus and then waits to hear something back on the data bus. When the CPU wants to write to a certain address, it puts the address onto the address bus and the 8-bit value it wants to write onto the data bus.

A "normal" 6502 computer has three additional components connected through these buses to the CPU. The first is a RAM module, which makes up general space that the CPU can use for computation. The second is a ROM module, which makes up the initial code and data to be run by the CPU. The RAM begins completely zeroed out, meaning that there has to be something which stores the initial program to be run. The ROM serves this purpose.

The final additional component is an I/O device. The I/O device is essentially a very small RAM module. When the CPU writes a byte to the I/O device, the device stores the byte and then puts it onto 8 external pins. When the CPU reads a byte from the device, the device sends back the data that it sees on those pins. This makes it very convenient to then connect those pins to a screen, keyboard, or mouse. In order to get a value for external use from the RAM, the hardware has to actively give it an address, whereas the I/O device makes its data much more accessible.

Each of these components has a chip-select pin, which essentially makes it responsive to interactions from the CPU. You use the chip-select pin to configure the memory layout that the CPU sees. For example, you could use a wire to connect the MSB of the CPU's address bus to the RAM's chip-select. Then, if the CPU tries to read address `$9000`, the RAM will respond with the data that is located there in RAM, but if the CPU reads address `$1000`, the RAM will not react (and some other component might have the chance to do so).

In this virtual 6502 computer, the CPU sees the following memory layout:

* `$0000-$7fff`: RAM
* `$8000-$8fff`: I/O
* `$9000-$ffff`: ROM

## 2. The Screen (drivers/graphics.c)

The screen is a 256x256 16-color display. Because the color of each pixel can be represented with 4 bits, the state of the screen is stored as an "interal RAM" module consisting of 32768 (256 * 256 / 2) bytes, where each byte represents the state of a pair of pixels.

The screen is accessible to the CPU by using three ports on the I/O device. Writing to `$8000` will set up the low byte of the address to the internal RAM of the screen, writing to `$8001` will set up the high byte, and writing to `$8002` will write actual color data to the place in the screen's internal RAM designated by `$8000` and `$8001`.

The function `hline(x,w,y)` uses these I/O ports to draw a horizontal line of length `w` starting at screen pixel position `(x,y)`. The function `krectangle(x,w,y,h)` uses a loop of calls to `hline` to draw a solid rectangle of height `w` x `h` with top-left corner `(x,y)`.

## 3. Memory Banks

Modern CPUs have features such as segmentation and paging that make it possible for a program to read from one byte in memory and actually get back a different one. This mapping of what a program thinks it is reading to what it is actually reading is configured by the OS. This is useful because it means that programs do not have to worry about what spaces in memory are used by other programs. For example, if two instances of the same program are to be run simultaneously, they will both depend on e.g. memory address `$0001`. If the OS configures the mapping system so that, for one instance, `$0001` maps to `$1001`, and for the other, `$0001` maps to `$2001`, the programs will not interfere with each other.

The 6502 CPU does not have such a system built-in. However, if we expand the size of our RAM module so that it requires a 24-bit address, the lower 16 bits can remain connected to the address bus of the CPU while the upper 8 bits can be connected to an 8-bit port on the I/O device (I chose `$8004` as the port). Then, before running task 1, the OS can set `$8004` to `$01`, and task 1's read from `$0001` will be mapped to `$010001` on the RAM. Before running task 2, the OS sets `$8004` to `$02`, so task 2's read from `$0001` will be mapped to `$020001`. In effect, this achieves the same goals as a modern memory management system.

I refer to a RAM region of `$10000` as a memory bank, and the value written to `$8004` is the memory bank index.

## 4. Basic Multitasking (tasks/context.s)

Every 100k instructions, the emulator will send the CPU a non-maskable interrupt (NMI). Regardless of what code the CPU is running when it receives the NMI, it will be forced to start running code designated by a special pointer to an OS function. This means that NMI can be used to create multitasking, as tasks will automatically be paused and control will be passed to the OS code. The OS can then resume a different task. Even if a malicious task wants to hog all the CPU time, the CPU will still eventually receive an NMI, allowing the OS to get back control and give another task some CPU time.

It is important that the running state of the CPU be stored exactly when an NMI occurs so that, when a task resumes, its registers and variables have not been clobbered by the OS. Because C code could change the CPU's state in unexpected ways, the code for pausing tasks when an NMI is received and for resuming tasks is written in assembly language.

As explained above, each task is given its own memory bank, with memory bank 0 being reserved for the OS. When the OS' C code calls the assembly function to resume a task, `continue_task(memory_bank)`, the function saves the state of the CPU in memory bank 0, switches to the memory bank of the task designated, restores the state of the CPU as stored in the task's memory bank, and returns to the place where the task was interrupted by the NMI. When an NMI occurs, the assembly code under `_nmi_int` saves the state of the CPU in the task's memory bank, switches to memory bank 0, restores the state of the CPU as stored in memory bank 0, and returns to the part of the C code immediately after the call to continue_task. This allows an easy interface between C and assembly and allows most of the task scheduling logic (in `run_tasks()`) to be written in C.

## 5. Security

The memory bank logic in our CPU provides an extra benefit, which is that one program can't tamper with the memory being used by another. However, right now, this is very easy to circumvent, because all a program has to do is write to `$8004` and it will be able to access other tasks' memory. In addition, we might not want all tasks to be able to access the I/O directly; for example, we might not want every program to be able to format the disk.

To prevent this, a flag on the I/O device itself (`$8005`), when set, will prevent any further writes to I/O. In hardware, this might be implemented by somehow completely disabling the I/O device's chip-select pin. An NMI will clear this flag and allow further access to I/O. As long as the OS sets this flag before resuming a task, no task will be able to directly write to the I/O device. Upon an NMI, at the same moment when access to I/O is regained, CPU control is passed back to OS code, making it so that only the OS can access I/O.

## 6. System calls (tasks/tasks.c, stdlib/syscall.c)

Of course, programs still need to be able to draw to the screen, etc., and since only the OS can access I/O, there needs to be some form of communication between programs and the OS. The assembly function that pauses a task when an NMI is received copies the memory located at $7f00-$7fef from the task's memory bank to memory bank 0. Therefore, these bytes can be used as an interaction space that the program writes to and the OS reads from.

While running, a program can write "packets" to this interaction space. For example, one of the only syscalls implemented so far draws a rectangle on the screen; the code for this syscall is $01. Therefore, if a task writes `$01` to `$7f00`, followed by data for the x position, width, y position, height, and color (one byte each), then when the NMI occurs and the OS gets control, it can read address `$7f00` and see the packet.

The function `process_syscalls(memory_bank)` is responsible for reading the interaction space and carrying out the syscalls, whereas `syscall.c` contains utility functions to be used by programs. These utility functions simply write packets into the interaction space to later be read by the OS.

## 7. Printing text to the screen (drivers/graphics.c)

In order to draw text to the screen, 

## I/O Device Reference

* `$8000`: Screen pixel low byte
* `$8001`: Screen pixel high byte
* `$8002`: Screen color (write to draw on screen)
* `$8003`: Serial print
* `$8004`: Memory bank index
* `$8005`: I/O device lock
* `$8005`: Mouse X pixel
* `$8006`: Mouse Y pixel
* `$8007`: Mouse/keyboard last event (write to clear)
* `$8008`: Disk CHS low byte
* `$8009`: Disk CHS high byte
* `$800a`: Disk DMA bank (7 MSB bank index, LSB read/write)