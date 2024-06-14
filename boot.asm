[org 0x7c00]
mov ah, 0x0e
mov bx, questionName
call printString
mov bx, userInput
xor cx, cx

readInput:
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je finishInput
    mov ah, 0x0e
    int 0x10
    mov [bx], al
    inc bx
    inc cx
    jmp readInput

finishInput:
    mov byte [bx], 0x00

    mov bx, userInput
    call printString

jmp $

printString:
    mov al, [bx]
    cmp al, 0
    je return
    int 0x10
    inc bx
    jmp printString

return:
    ret

questionName:
    db "What is the string you want to know the number of vowels in?", 0x0A, 0x0D, 0

userInput:
    times 100 db 0

times 510-($-$$) db 0
db 0x55, 0xaa
