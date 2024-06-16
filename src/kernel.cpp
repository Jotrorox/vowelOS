void print(const char* str) {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
    }
}

extern "C" void main(){
    print("Hello, World!");
    return;
}