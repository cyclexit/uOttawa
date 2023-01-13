#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "shm_utils.h"

void help() {
  printf("Usage: catalan_producer n\n");
  printf("n is the length of the Catalan numbers.\n");
  printf("n should be a positive integer.\n");
}

long long calc_catalan(long long n) {
  long long res = 1, last_res = 1;
  for (long long i = 1; i < n; ++i) {
    res = (4 * i + 2) * last_res / (i + 2);
    last_res = res;
  }
  return res;
}

int main(int argc, char* argv[]) {
  // parse the args
  int n;
  if (argc != 2) {
    help();
    exit(0);
  }
  if (sscanf(argv[1], "%d", &n) != 1 || n < 1) {
    printf("ERROR: Invalid argument.\n\n");
    help();
    exit(0);
  }

  // get the shared memory
  char* shm = (char*) attach_shm(FILE_NAME, SHM_SIZE);
  if (shm == NULL) {
    printf("ERROR: Failed to get shared memory.\n");
    return SHM_ERROR_CODE;
  }

  // generate Catalan numbers and write to the shared memory
  long long val, shm_idx = 0;
  printf("First %d Catalan numbers: ", n);
  for (long long i = 1; i <= n; ++i) {
    val = calc_catalan(i);
    shm_idx += sprintf(&shm[shm_idx], "%lld ", val);
    printf("%lld ", val);
    if (i == n) printf("\n");
  }

  // detach the shared memory
  detach_shm((void*) shm);

  return 0;
}