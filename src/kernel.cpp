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

void print(char c)
{
    char *videoMemory = (char *)VIDEO_ADDRESS;
    if (c == '\n')
    {
        cursorX = 0;
        cursorY++;
    }
    else
    {
        videoMemory[(cursorY * MAX_COLS + cursorX) * 2] = c;
        videoMemory[(cursorY * MAX_COLS + cursorX) * 2 + 1] = WHITE_ON_BLACK;
        cursorX++;
    }

    if (cursorX >= MAX_COLS)
    {
        cursorX = 0;
        cursorY++;
    }

    if (cursorY >= MAX_ROWS)
    {
        cursorY = 0;
    }
}

void print(const char *str)
{
    for (int i = 0; str[i] != '\0'; ++i)
    {
        print(str[i]);
    }
}

void print(int num)
{
    char str[128];
    int i = 0;
    while (num)
    {
        str[i++] = num % 10 + '0';
        num /= 10;
    }

    if (i == 0)
    {
        str[i++] = '0';
    }

    str[i] = '\0';

    for (int j = i - 1; j >= 0; --j)
    {
        print(str[j]);
    }
}

const char keymap[] = {
    0, 27, '1', '2', '3', '4', '5', '6', '7', '8',
    '9', '0', '-', '=', '\b', '\t', 'q', 'w', 'e', 'r',
    't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', '?',
    'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
    '\'', '`', '#', '\\', 'z', 'x', 'c', 'v', 'b', 'n',
    'm', ',', '.', '/', ' ',
};

char getAsciiFromScanCode(unsigned char scancode)
{
    if (scancode < sizeof(keymap))
    {
        return keymap[scancode];
    }
    return 0;
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

void main()
{
    while (true)
    {
        print("Enter a string: \n");

        char str[256];
        int i = 0;

        while (true && i < 255)
        {
            char c = getChar();

            if (c == '\n')
            {
                break;
            }

            print(c);

            str[i] = c;
            i++;
        }

        str[i] = '\0';

        print("\n");

        int vowels = countVowels(str);

        print("Number of vowels: ");
        print(vowels);
        print("\n\n");
    }

    return;
}