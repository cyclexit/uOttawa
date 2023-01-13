#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  fork();
  fork();
  fork();
  // 2^n process where n is the number of the fork call.
  printf("Hello world!\n");
  return 0;
}