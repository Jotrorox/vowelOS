; boot.asm
[org 0x7c00] ; Origin, BIOS loads boot sector here

start:
    mov ax, 0x07C0 ; Set up segments
    add ax, 0x20   ; Adjust for space taken by BIOS
    mov ds, ax     ; Data segment
    mov es, ax     ; Extra segment

    mov si, msg    ; Point SI to our message
    call print     ; Call our print function

hang:
    jmp hang       ; Hang in infinite loop

print:
    lodsb          ; Load next character from string to AL
    or al, al      ; Test if end of string
    jz return      ; If zero flag set, return
    mov ah, 0x0E   ; BIOS teletype function
    int 0x10       ; Call video services
    jmp print      ; Repeat until done

return:
    ret            ; Return from subroutine

msg db 'Hello, World!', 0 ; Our message ends with a null byte

times 510 - ($ - $$) db 0 ; Pad remainder of boot sector with zeros
dw 0xAA55               ; Boot signature at the end of the 512-byte sector
