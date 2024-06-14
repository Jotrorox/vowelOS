[org 0x7c00]
mov ah, 0x0e ; Set AH for teletype output function
mov bx, questionName
call printString ; Print the question
mov bx, userInput ; Point BX to the start of userInput
xor cx, cx ; Clear CX, which will count the number of characters read

readInput:
    mov ah, 0x00
    int 0x16 ; Wait for key press
    cmp al, 0x0D ; Check if Enter key (carriage return) was pressed
    je finishInput ; Jump to finishInput if Enter was pressed
    mov ah, 0x0e
    int 0x10 ; Echo the character
    mov [bx], al ; Store the character in userInput
    inc bx ; Move to the next byte in userInput
    inc cx ; Increment character count
    jmp readInput ; Repeat the loop

finishInput:
    mov byte [bx], 0x00 ; Null-terminate the string

    ; Print a newline before printing the user input
    mov ah, 0x0e ; Set AH for teletype output function
    mov al, 0x0A ; Line feed
    int 0x10 ; Print the line feed
    mov al, 0x0D ; Carriage return
    int 0x10 ; Print the carriage return

    lea bx, [userInput] ; Load the offset of userInput into BX
    call printString ; Call printString to print the entered string

jmp $ ; Infinite loop to prevent the CPU from executing beyond the boot sector

printString:
    mov al, [bx] ; Load the next character into AL
    cmp al, 0 ; Check if it's the null terminator
    je return ; If it is, return to the caller
    mov ah, 0x0e ; Set AH for teletype output function
    int 0x10 ; Print the character
    inc bx ; Move BX to the next character
    jmp printString ; Loop back to print the next character

return:
    ret ; Return to the caller

questionName:
    db "What is the string you want to know the number of vowels in?", 0x0A, 0x0D, 0

userInput:
    times 100 db 0 ; Reserve 100 bytes for userInput

times 510-($-$$) db 0 ; Pad the boot sector to 510 bytes
db 0x55, 0xaa ; Boot signature