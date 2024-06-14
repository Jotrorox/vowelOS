[org 0x7c00]
mov ah, 0x0e
mov bx, questionName

printString:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp printString

int 0x10

end:
    jmp $

questionName:
    db "What is the string you want to know the number of vowels in?", 0

times 510-($-$$) db 0
db 0x55, 0xaa