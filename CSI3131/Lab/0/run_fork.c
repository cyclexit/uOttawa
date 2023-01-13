#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
  int rc = fork();
  // printf("rc = %d\n", rc);
  if (rc == 0) {
    printf("I am child, %d\n", getpid());
  } else if (rc > 0) {
    printf("I am parent, %d\n", getpid());
  } else {
    printf("fork error\n");
    exit(1);
  }
  return 0;
}