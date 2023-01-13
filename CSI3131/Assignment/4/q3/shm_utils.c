#include <stdbool.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#include "shm_utils.h"

static int get_shm(char* file_name, int size) {
  key_t key = ftok(file_name, 0);
  if (key == SHM_ERROR_CODE) {
    return SHM_ERROR_CODE;
  }

  // get the shared memory block, and create if it does not exist yet
  return shmget(key, size, 0644 | IPC_CREAT);
}

void* attach_shm(char* file_name, int size) {
  int shm_id = get_shm(file_name, size);
  if (shm_id == SHM_ERROR_CODE) {
    return NULL;
  }

  // map the shared memory block to the process's memory
  void* res = shmat(shm_id, NULL, 0);
  if (*(int*) res == SHM_ERROR_CODE) {
    return NULL;
  }

  return res;
}

bool detach_shm(void* shm) {
  return (shmdt(shm) != SHM_ERROR_CODE);
}

bool destroy_shm(char* file_name) {
  int shm_id = get_shm(file_name, 0);
  if (shm_id == SHM_ERROR_CODE) {
    return false;
  }
  return (shmctl(shm_id, IPC_RMID, NULL) != SHM_ERROR_CODE);
}