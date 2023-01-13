#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void help() {
  printf("Usage: prime NUM\n");
  printf("Print all prime numbers less than or equal to NUM. NUM is an integer.\n");
}

bool is_prime(int num) {
  for (int i = 2; i <= num / i; ++i) {
    if (num % i == 0) {
      return false;
    }
  }
  return true;
}

void* print_prime(void* arg) {
  int* num_ptr = (int *) arg;
  int num = *num_ptr;
  for (int i = 2; i <= num; ++i) {
    if (is_prime(i)) {
      printf("%d ", i);
    }
  }
  printf("\n");

  pthread_exit(NULL);
}

int main(int argc, char* argv[]) {
  // parse args
  int num;
  if (argc != 2) {
    help();
    exit(0);
  }
  if (sscanf(argv[1], "%d", &num) != 1) {
    printf("Failed to parse the command-line argument.\n\n");
    help();
    exit(0);
  }

  // create thread to print primes
  pthread_t tid;
  pthread_attr_t t_attr;
  pthread_attr_init(&t_attr);
  pthread_create(&tid, &t_attr, print_prime, &num);

  // join the thread when the job is done
  pthread_join(tid, NULL);
  return 0;
}