# Define compiler and flags
NASM := nasm
DD := dd
QEMU := qemu-system-x86_64

# Source and output files
BOOT_ASM := boot.asm
BOOT_BIN := boot.bin
BOOT_IMG := boot.img

# Default target
all: $(BOOT_IMG)

# Rule to assemble the bootloader
$(BOOT_BIN): $(BOOT_ASM)
	$(NASM) -f bin $< -o $@

# Rule to create the bootable disk image
$(BOOT_IMG): $(BOOT_BIN)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$(BOOT_BIN) of=$@ conv=notrunc

# Rule to run the bootable image in QEMU
run: $(BOOT_IMG)
	$(QEMU) -fda $<

# Rule to clean up generated files
clean:
	rm -f $(BOOT_BIN) $(BOOT_IMG)

.PHONY: all run clean
