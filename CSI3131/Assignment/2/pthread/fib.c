#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// make the array in the shared memory
int* fib;

void help() {
  printf("Usage: fib n\n");
  printf("Print the first n elements in the fibonacci sequence.\n");
  printf("n should be a positive integer.\n");
}

void* calc_fib(void* arg) {
  int* n_ptr = (int*) arg;
  int n = *n_ptr;
  for (int i = 2; i <= n; ++i) {
    fib[i] = fib[i - 1] + fib[i - 2];
  }
  pthread_exit(NULL);
}

int main(int argc, char* argv[]) {
  // parse args
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

  // create the arrary
  fib = (int*) malloc((n + 1) * sizeof(int));
  fib[0] = 0;
  fib[1] = 1;

  // create a thread to calculate fibonacci sequence
  pthread_t tid;
  pthread_attr_t t_attr;
  pthread_attr_init(&t_attr);
  pthread_create(&tid, &t_attr, calc_fib, &n);

  // join the thread when the job is finished
  pthread_join(tid, NULL);

  // print the answer
  for (int i = 0; i <= n; ++i) {
    printf("%d ", fib[i]);
  }
  printf("\n");
  return 0;
}