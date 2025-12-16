#include <stdint.h>

// Простая функция для теста: сложение
__attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

// Заготовка для обработки кадра (если захотите подключить камеру позже)
__attribute__((visibility("default"))) __attribute__((used))
void process_frame_dummy(uint8_t* plane, int size) {
    // Здесь мог бы быть ваш код обработки видео
    if (size > 0 && plane != 0) {
        plane[0] = 255; // Пример изменения памяти
    }
}
