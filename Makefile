all: run

build:
	@mkdir -p build
	@nasm -f bin boot.asm -o build/vowelOS.bin > /dev/null

run:
	@make build
	@qemu-system-x86_64 -drive format=raw,file=build/vowelOS.bin > /dev/null

clean:
	@rm -rf build

.PHONY: all build run clean