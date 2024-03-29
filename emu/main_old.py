import sys,array,time
from pcpu import CPU
from mmu import MMU
from hdd import read_hdd_page

logging = "logging" in sys.argv
frame_logging = "frame" in sys.argv
graphics = "nographics" not in sys.argv

COLORS = [
    (0,0,0),
    (0,0,255),
    (0,255,0),
    (0,255,255),
    (255,0,0),
    (255,0,255),
    (255,255,0),
    (255,255,255)
]

if graphics:
    import pygame
    pygame.init()
    screen = pygame.display.set_mode((512,512))
    screen.fill((0,0,0))
    pygame.display.set_caption("6502")
    clock = pygame.time.Clock()

alterations = []
screen_matrix = array.array("B",[0] * 256 * 128)
screen_matrix_pointer = 0
mouse_pos = (0,0)
mouse_down = False
mouse_impulse = False
key_down = 0

def io_write(index,value):
    if logging:
        print("io",hex(index),hex(value))

    global screen_matrix,screen_matrix_pointer,key_down,mouse_impulse,mmu

    if index == 0:
        # Screen lo
        screen_matrix_pointer = (screen_matrix_pointer & 0xff00) | value
    elif index == 1:
        # Screen hi
        screen_matrix_pointer = (screen_matrix_pointer & 0x00ff) | (value << 8)
    elif index == 2:
        # Screen data
        alterations.append([screen_matrix_pointer,value])
        screen_matrix[screen_matrix_pointer] = value
    elif index == 3:
        # Serial data
        print(chr(value),end="",flush=True)
    elif index == 7:
        key_down = 0
        mouse_impulse = False
    elif index == 8:
        read_hdd_page(mmu,value)

def io_read(index):
    if index == 2:
        # Screen data
        return screen_matrix[screen_matrix_pointer]
    elif index == 5:
        # Mouse X
        return mouse_pos[0] // 2
    elif index == 6:
        # Mouse Y
        return mouse_pos[1] // 2
    elif index == 7:
        return key_down | (mouse_impulse << 7)
    else:
        return -1 # MMU will default to last written byte

rom_image = open("a.out","rb").read()
mmu = MMU(rom_image,io_write,io_read,logging)
cpu = CPU(mmu,logging=logging)
cpu.r.pc = cpu.interruptAddress("RESET")

read_hdd_page(mmu,0)

try:
    while True:
        start_time = time.time()
        if graphics:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    sys.exit()
                elif event.type == pygame.KEYDOWN:
                    key_down = event.key
            for alteration in alterations:
                y = alteration[0] // 128
                x = alteration[0] % 128
                pygame.draw.rect(screen,COLORS[(alteration[1] & 0xf0) >> 4],(x * 4,y * 2,2,2))
                pygame.draw.rect(screen,COLORS[alteration[1] & 0x0f],(x * 4 + 2,y * 2,2,2))
            alterations = []
            mouse_pos = pygame.mouse.get_pos()
            if pygame.mouse.get_pressed()[0] and not mouse_down:
                mouse_impulse = True
            mouse_down = pygame.mouse.get_pressed()[0]
            pygame.display.flip()

        cpu.interrupt("NMI")
        cpu_start_time = time.time()
        for i in range(10000):
            cpu.step()

        if frame_logging:
            frame_time = time.time() - start_time
            cpu_time = time.time() - cpu_start_time
            print("actual frame time: %.6s (1/%.4s) s (%.4s%% in CPU)" % (frame_time,1 / frame_time,cpu_time / frame_time * 100))
            
except KeyboardInterrupt:
    sys.exit()