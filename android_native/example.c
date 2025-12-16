
#include <stdint.h>

void invert_array(uint8_t* data, int length) {
    for (int i = 0; i < length; i++) {
        data[i] = 255 - data[i];
    }
}
