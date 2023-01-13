#ifndef SHM_UTILS_H
#define SHM_UTILS_H

#include <stdbool.h>

#define FILE_NAME "catalan_producer.c"
#define SHM_SIZE 4096
#define SHM_ERROR_CODE (-1)

void* attach_shm(char* file_name, int size);
bool detach_shm(void* shm);
bool destroy_shm(char* file_name);

#endif