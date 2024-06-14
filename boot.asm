; ==============================
; |       Initialization       |
; ==============================
[org 0x7c00]

; ============================== 
; |       Code Section         |
; ==============================
start:

mov ah, 0x0e
mov bx, questionName
call printString
mov bx, userInput
xor cx, cx

; ------------------------------
;         Read Input
; ------------------------------

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
    call printEmptyLine
    mov bx, cx
    call printNumber
    call printEmptyLine
    call printEmptyLine

jmp start

; ------------------------------
;         Functions
; ------------------------------

printString:
    mov al, [bx]
    cmp al, 0
    je return
    mov ah, 0x0e
    int 0x10
    inc bx
    jmp printString

printNumber:
    add bx, '0'
    mov ah, 0x0e
    mov al, bl
    int 0x10
    ret

printEmptyLine:
    mov ah, 0x0e
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    ret

return:
    ret

; ==============================
; |        Data Section        |
; ==============================
questionName:
    db "What is the string you want to know the number of vowels in?", 0x0A, 0x0D, 0

userInput:
    times 100 db 0

; ==============================
; |        Boot Sector         |
; ==============================
times 510-($-$$) db 0
db 0x55, 0xaa
