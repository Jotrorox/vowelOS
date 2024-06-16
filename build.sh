#!/bin/bash

rm -rf build
mkdir -p build

i386-elf-gcc -ffreestanding -m32 -g -c "src/kernel.cpp" -o "build/kernel.o"
nasm "src/kernel_entry.asm" -f elf -o "build/kernel_entry.o"
i386-elf-ld -o "build/full_kernel.bin" -Ttext 0x1000 "build/kernel_entry.o" "build/kernel.o" --oformat binary
nasm "src/bootloader.asm" -f bin -o "build/bootloader.bin"
cat "build/bootloader.bin" "build/full_kernel.bin" > "build/bootable_kernel.bin"
nasm "src/zero_sect.asm" -f bin -o "build/zero_sect.bin"
cat "build/bootable_kernel.bin" "build/zero_sect.bin" > "build/OS.bin"