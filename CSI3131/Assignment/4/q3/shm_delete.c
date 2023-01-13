#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "shm_utils.h"

int main(int argc, char* argv[]) {
  if (destroy_shm(FILE_NAME)) {
    printf("Shared memory for %s is deleted.\n", FILE_NAME);
  } else {
    printf("ERROR: Failed to delete the shared memory for %s\n", FILE_NAME);
  }
  return 0;
}