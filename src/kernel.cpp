#define KEYBOARD_PORT 0x60
#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

int cursorX = 0;
int cursorY = 0;

void setCursor(int x, int y)
{
    cursorX = x;
    cursorY = y;
}

void clearScreen()
{
    char *videoMemory = (char *)VIDEO_ADDRESS;
    for (int i = 0; i < MAX_COLS * MAX_ROWS; i++)
    {
        videoMemory[i * 2] = ' ';
        videoMemory[i * 2 + 1] = WHITE_ON_BLACK;
    }

    setCursor(0, 0);
}

void print(char *str)
{
    char *videoMemory = (char *)VIDEO_ADDRESS;
    int offset = (cursorY * MAX_COLS + cursorX) * 2;
    for (int i = 0; str[i] != '\0';)
    {
        // Handle newline characters
        if (str[i] == '\n')
        {
            cursorY++;
            cursorX = 0;
            i++;
            continue;
        }

        // Check if the character is a single-byte ASCII character
        if ((unsigned char)str[i] <= 0x7F)
        {
            videoMemory[offset] = str[i];
            videoMemory[offset + 1] = WHITE_ON_BLACK;
            cursorX++;
            i++; // Move to the next character
        }
        else
        {
            // For non-ASCII characters, you can add handling here
            // For now, we'll just skip them
            i++; // Skip this character as a simple way to avoid displaying random characters
                 // Note: This is not a proper UTF-8 handling mechanism
        }

        offset = (cursorY * MAX_COLS + cursorX) * 2;

        // Ensure we wrap text to the next line if we reach the end of the current line
        if (cursorX >= MAX_COLS)
        {
            cursorX = 0;
            cursorY++;
        }
    }
}

void print(int number)
{
    char str[32];
    int i = 0;
    while (number > 0)
    {
        str[i] = number % 10 + '0';
        number /= 10;
        i++;
    }
    str[i] = '\0';
    char temp;
    for (int j = 0; j < i / 2; j++)
    {
        temp = str[j];
        str[j] = str[i - j - 1];
        str[i - j - 1] = temp;
    }
    print(str);
}

void print(char c)
{
    char str[2] = {c, '\0'};
    print(str);
}

const char keymap[] = {
    0,   27, '1', '2', '3', '4', '5', '6', '7', '8',
    '9', '0', '-', '=', '\b', '\t',
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[',
    ']', '\n', '?', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
    '\'', '`', '#', '\\', 'z', 'x', 'c', 'v', 'b', 'n',
    'm', ',', '.', '/', ' ',
};

char getAsciiFromScanCode(unsigned char scancode)
{
    if (scancode < sizeof(keymap))
    {
        return keymap[scancode];
    }
    return 0; // Return null character if unknown
}

char getChar()
{
    unsigned char scancode;
    asm volatile(
        "1:\n\t"
        "inb $0x64, %%al\n\t"
        "testb $0x01, %%al\n\t"
        "jz 1b\n\t"
        "inb $0x60, %%al\n\t"
        "mov %%al, %0"
        : "=r"(scancode)
        :
        : "%al");
    
    return getAsciiFromScanCode(scancode & 0x7F);
}

int strlen(const char *str)
{
    int len = 0;
    while (str[len])
    {
        len++;
    }
    return len;
}

int countVowels(const char *str)
{
    int count = 0;
    for (int i = 0; str[i] != '\0'; ++i)
    {
        if (str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u')
        {
            count++;
        }
    }
    return count;
}

extern "C" void main()
{
    clearScreen();

    print("Hallo Welt\n");
    print("Hello World\n");

    print(countVowels("Hello World\n"));

    print("\n");

    print('a');

    while (true)
    {
        char c = getChar();
        print(c);
    }

    return;
}