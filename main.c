#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sha256.h"

void print_vector(const unsigned char *buf, size_t size)
{
    for (size_t i = 0; i < size; i++) {
        printf("%x%x", buf[i] >> 4, buf[i] & 0x0f);
    }
    printf(":\n");
}

int main(void)
{
	unsigned char r[32];
	blk_SHA256(r, "abc", 3);
	print_vector(r, 32);

	return 0;
}
