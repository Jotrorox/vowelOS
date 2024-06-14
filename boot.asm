[org 0x7c00]
mov ah, 0x0e ; Set AH for printing

; Print the question
mov bx, questionName
call printString

; Prepare for reading input
mov bx, userInput ; BX points to the buffer where user input will be stored
xor cx, cx        ; CX will keep track of the number of characters read

readInput:
    mov ah, 0x00 ; Function 0x00 of INT 16h waits for a key press
    int 0x16     ; Wait for and get the pressed key
    cmp al, 0x0D ; Check if the key is Enter (carriage return)
    je finishInput ; If Enter is pressed, end input
    mov ah, 0x0e ; Prepare for printing the character (echo back)
    int 0x10     ; Print the character
    mov [bx], al ; Store the character in the buffer
    inc bx       ; Move to the next position in the buffer
    inc cx       ; Increment the count of characters read
    jmp readInput ; Loop back to read the next character

finishInput:
    mov byte [bx], 0x00 ; Null-terminate the string

    ; Count the number of vowels in the user input
    mov si, userInput ; SI points to the user input buffer
    xor ax, ax        ; AX will keep track of the number of vowels
countVowels:
    mov al, [si] ; Load the next character into AL
    cmp al, 0   ; Check if it's the null terminator
    je finishCount ; If it is, finish counting
    cmp al, 'a'  ; Compare with 'a'
    je incrementVowel ; If equal, increment vowel count
    cmp al, 'e'  ; Compare with 'e'
    je incrementVowel ; If equal, increment vowel count
    cmp al, 'i'  ; Compare with 'i'
    je incrementVowel ; If equal, increment vowel count
    cmp al, 'o'  ; Compare with 'o'
    je incrementVowel ; If equal, increment vowel count
    cmp al, 'u'  ; Compare with 'u'
    je incrementVowel ; If equal, increment vowel count
    inc si       ; Move to the next character
    jmp countVowels ; Loop back to count the next character

incrementVowel:
    inc ax       ; Increment the vowel count
    inc si       ; Move to the next character
    jmp countVowels ; Loop back to count the next character

finishCount:
    ; Print the number of vowels
    mov ah, 0x0e ; Set AH for printing
    mov al, ' '  ; Print a space
    int 0x10     ; Print the space character
    mov ax, cx   ; Move the count of characters read to AX
    call printNumber ; Print the number in AX
    jmp $ ; Infinite loop to prevent the CPU from executing beyond the boot sector

printNumber:
    xor cx, cx   ; CX will keep track of the number of digits
    mov bx, 10   ; BX is the divisor
    mov dx, 0    ; DX will hold the remainder
    push ax      ; Save AX on the stack
convertLoop:
    xor dx, dx   ; Clear DX before division
    div bx       ; Divide AX by BX
    add dl, '0'  ; Convert the remainder to ASCII
    push dx      ; Push the remainder on the stack
    inc cx       ; Increment the count of digits
    test ax, ax  ; Check if AX is zero
    jnz convertLoop ; If not zero, loop back to divide again

printLoop:
    pop dx       ; Pop the remainder from the stack
    mov ah, 0x0e ; Set AH for printing
    mov al, dl   ; Move the remainder to AL
    int 0x10     ; Print the digit
    dec cx       ; Decrement the count of digits
    jnz printLoop ; If not zero, loop back to print the next digit

    pop ax       ; Restore AX from the stack
    ret

jmp $ ; Infinite loop to prevent the CPU from executing beyond the boot sector

printString:
    mov al, [bx] ; Load the next character into AL
    cmp al, 0    ; Check if it's the null terminator
    je return    ; If it is, return from the subroutine
    int 0x10     ; Print the character
    inc bx       ; Move to the next character
    jmp printString ; Loop back to print the next character
return:
    ret

questionName:
    db "What is the string you want to know the number of vowels in?", 0x0D, 0x0A, 0

userInput:
    times 100 db 0 ; Explicitly initialize 100 bytes to 0

times 510-($-$$) db 0
db 0x55, 0xaa