#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "shm_utils.h"

int main(int argc, char* argv[]) {
  // get the shared memory
  char* shm = (char*) attach_shm(FILE_NAME, SHM_SIZE);

  // print the data in the shared memory
  printf("From shared memory:");
  printf("%s\n", shm);

  // detach the shared memory
  detach_shm((void*) shm);

  return 0;
}