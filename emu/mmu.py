import array

class MMU:
    def __init__(self,rom_image,io_write,io_read,logging=False):
        self.rom = array.array("B",[0] * 0x7000)
        self.ram = array.array("B",[0] * 0x20000)
        self.ram_pointer = 0x0
        self.io_buffer = [0] * 16

        for i in range(len(rom_image)):
            self.rom[i] = rom_image[i]

        self.io_write = io_write
        self.io_read = io_read
        
        self.logging = logging

    def reset(self):
        self.ram = array.array("B",[0] * 0x20000)

    def write(self,address,value):
        if self.logging:
            print("write",hex(address))
        if address < 0x8000:
            self.ram[(self.ram_pointer << 15) + address] = value & 0xff
        elif address < 0x9000:
            io_index = address % 16
            if io_index == 4:
                self.ram_pointer = value & 0x03
            else:
                self.io_write(io_index,value & 0xff)
            self.io_buffer[io_index] = value
        else:
            # rom write attempt
            pass

    def read(self,address):
        if self.logging:
            print("read",hex(address),end="")
        if address < 0x8000:
            if self.logging:
                print(" (ram %s)" % hex((self.ram_pointer << 15) + address))
            return self.ram[(self.ram_pointer << 15) + address]
        elif address < 0x9000:
            # io read
            if self.logging:
                print()
            io_index = address % 16
            read_value = self.io_read(io_index)
            if read_value != -1:
                return read_value
            else:
                return self.io_buffer[io_index]
        else:
            if self.logging:
                print()
            return self.rom[address - 0x9000]

    def readWord(self, addr):
        return (self.read(addr + 1) << 8) + self.read(addr)
