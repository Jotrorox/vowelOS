#define KEYBOARD_PORT 0x60

void print(const char* str) {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
    }
}

void print(char* str) {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
    }
}

void print(char c) {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    video_memory[0] = (video_memory[0] & 0xFF00) | c;
}

void print(int i) {
    char str[11];
    int j = 0;
    if (i < 0) {
        print("-");
        i = -i;
    }
    while (i > 0) {
        str[j++] = (char)(i % 10 + '0');
        i /= 10;
    }
    if (j == 0) {
        str[j++] = '0';
    }
    for (int k = j - 1; k >= 0; --k) {
        print(str[k]);
    }
}

void print(unsigned int i) {
    char str[11];
    int j = 0;
    while (i > 0) {
        str[j++] = (char)(i % 10 + '0');
        i /= 10;
    }
    if (j == 0) {
        str[j++] = '0';
    }
    for (int k = j - 1; k >= 0; --k) {
        print(str[k]);
    }
}

void printNewLine() {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    for (int i = 80; i < 160; ++i) {
        video_memory[i] = (video_memory[i] & 0xFF00) | ' ';
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
    print(countVowels("hello world"));
    
    return;
}