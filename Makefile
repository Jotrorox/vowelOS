build:
	mkdir -p build
	nasm -f bin boot.asm -o build/vocalOS.bin

run:
	qemu-system-x86_64 build/vocalOS.bin

clean:
	rm -rf build