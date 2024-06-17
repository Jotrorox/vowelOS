#define KEYBOARD_PORT 0x60
#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

int cursorX = 0;
int cursorY = 0;

void clearScreen() {
    char* videoMemory = (char*) VIDEO_ADDRESS;
    for (int i = 0; i < MAX_COLS * MAX_ROWS; i++) {
        videoMemory[i * 2] = ' ';
        videoMemory[i * 2 + 1] = WHITE_ON_BLACK;
    }
}

void print(char* str) {
    char* videoMemory = (char*) VIDEO_ADDRESS;
    int offset = (cursorY * MAX_COLS + cursorX) * 2;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == '\n') {
            cursorY++;
            cursorX = 0;
        } else {
            videoMemory[offset] = str[i];
            videoMemory[offset + 1] = WHITE_ON_BLACK;
            cursorX++;
        }
        offset = (cursorY * MAX_COLS + cursorX) * 2;
    }
}

int strlen(const char* str) {
    int len = 0;
    while (str[len]) {
        len++;
    }
    return len;
}

int countVowels(const char* str) {
    int count = 0;
    for (int i = 0; str[i] != '\0'; ++i) {
        if (str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u') {
            count++;
        }
    }
    return count;
}

extern "C" void main(){
    print("Hallo Welt\n");
    print("Hello World\n");
    
    return;
}