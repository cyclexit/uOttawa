#include <pthread.h>
#include <semaphore.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void help() {
  printf("Usage: sol n\n");
  printf("n is the number of the student threads.\n");
  printf("n should be a positive integer.\n");
}

// TA
const int MAX_HELP_TIME = 5;
int is_sleeping = 0;

// student
const int MAX_PROG_TIME = 5;
pthread_t* stu_threads;
int* stu_ids;

// hallway
#define HALLWAY_SIZE 3
int hallway[HALLWAY_SIZE]; // contain stu_id; CRITICAL SECTION!
int nxt_wait = 0;
int nxt_help = 0;
int cur_waiting = 0;

int is_waiting(int stu_id) {
  for (int i = 0; i < HALLWAY_SIZE; ++i) {
    if (hallway[i] == stu_id) {
      return 1;
    }
  }
  return 0;
}

// thread utils
int is_running = 1;
sem_t stu_post;
sem_t ta_post;
pthread_mutex_t mutex_lock;

void* ta_work(void* arg) {
  while (is_running) {
    if (cur_waiting > 0) {
      if (is_sleeping) {
        is_sleeping = 0;
        printf("TA wakes up.\n");
      }
      
      // help student; access hallway
      sem_wait(&stu_post);

      pthread_mutex_lock(&mutex_lock);
      int helped_stu_id = hallway[nxt_help++];
      nxt_help %= HALLWAY_SIZE;
      --cur_waiting;
      pthread_mutex_unlock(&mutex_lock);
      
      int help_time = rand() % MAX_HELP_TIME + 1;
      printf("TA: Help Student %d for %ds\n", helped_stu_id, help_time);
      sleep(help_time);
      
      sem_post(&ta_post);
    } else {
      if (!is_sleeping) {
        printf("TA: No student. Go to sleep\n");
        is_sleeping = 1;
      }
    }
  }

  printf("TA thread exit\n");
  // Make the waiting threads continue and exit
  for (int i = 0; i < cur_waiting; ++i) {
    sem_post(&ta_post);
  }
  pthread_exit(NULL);
}

void* stu_work(void* arg) {
  int my_id = *(int*) arg;

  while (is_running) {
    if (is_waiting(my_id)) continue;

    int prog_time = rand() % MAX_PROG_TIME + 1;
    printf("Student %d programming for %ds\n", my_id, prog_time);
    sleep(prog_time);

    if (cur_waiting < HALLWAY_SIZE) {
      // access hallway
      pthread_mutex_lock(&mutex_lock);
      hallway[nxt_wait++] = my_id;
      nxt_wait %= HALLWAY_SIZE;
      ++cur_waiting;
      pthread_mutex_unlock(&mutex_lock);
      
      // notify TA
      sem_post(&stu_post);
      sem_wait(&ta_post);
    } else {
      printf("Student %d: Hallway is full. Go back.\n", my_id);
    }
  }

  printf("Student %d thread exit\n", my_id);
  pthread_exit(NULL);
}

int main(int argc, char* argv[]) {
  // parse the argument
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

  // init hallway
  for (int i = 0; i < HALLWAY_SIZE; ++i) {
    hallway[i] = -1; // -1 means no student in the seat
  }

  // init thread utils
  sem_init(&stu_post, 0, 0);
  sem_init(&ta_post, 0, 1);
  pthread_mutex_init(&mutex_lock, NULL);

  // create 1 TA thread and n student threads
  printf("\nPress any key to terminate\n\n");

  pthread_attr_t attr;
  pthread_attr_init(&attr);
  
  pthread_t ta_thread;
  pthread_create(&ta_thread, NULL, ta_work, NULL);

  stu_threads = (pthread_t*) malloc(n * sizeof(pthread_t));
  stu_ids = (int*) malloc(n * sizeof(int));
  for (int i = 0; i < n; ++i) {
    stu_ids[i] = i;
    pthread_create(&stu_threads[i], &attr, stu_work, &stu_ids[i]);
  }

  // capture the key and set is_running to 0
  getchar();
  is_running = 0;

  // join threads
  pthread_attr_destroy(&attr);
  pthread_join(ta_thread, NULL);
  for (int i = 0; i < n; ++i) {
    pthread_join(stu_threads[i], NULL);
  }
  free(stu_threads);
  free(stu_ids);

  // destroy thread utils
  sem_destroy(&stu_post);
  sem_destroy(&ta_post);
  pthread_mutex_destroy(&mutex_lock);

  printf("Bye!\n");

  return 0;
}