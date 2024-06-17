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

if [ "$1" == "run" ]; then
    qemu-system-x86_64 -drive format=raw,file="build/OS.bin",index=0,if=floppy,  -m 128M
fi

if [ "$1" == "iso" ]; then
    dd if=/dev/zero of=build/floppy.img bs=1024 count=1440
    dd if=build/OS.bin of=build/floppy.img conv=notrunc

    mkisofs -o vowel.iso -b build/floppy.img .
fi