#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define PAGE_REF_LEN 20
#define MAX_PAGE_NUM 9

void help() {
  printf("Usage: page_replace n\n");
  printf("n is the number of page frames.\n");
  printf("n should be a positive integer in the range [1, 7].\n");
}

int page_ref[PAGE_REF_LEN];

int lru_get_idx(int* page_frames, int n, int* last_used) {
  int idx = 0;
  for (int i = 0; i < n; ++i) {
    if (page_frames[i] == -1) { // not used
      idx = i;
      break;
    } else if (last_used[page_frames[i]] < last_used[page_frames[idx]]) {
      idx = i;
    }
  }
  // printf("idx = %d\n", idx); // test
  return idx;
}

void lru(int n) {
  // init page_frames
  int page_frames[n];
  for (int i = 0; i < n; ++i) {
    page_frames[i] = -1;
  }

  // init in_page_frames
  int in_page_frames[MAX_PAGE_NUM + 1];
  for (int i = 0; i < MAX_PAGE_NUM + 1; ++i) {
    in_page_frames[i] = 0;
  }

  // init last_used
  int last_used[MAX_PAGE_NUM + 1];
  for (int i = 0; i < MAX_PAGE_NUM + 1; ++i) {
    last_used[i] = -1;
  }

  // simulate the page replacement and count page faults
  int page_faults = 0, idx;
  printf("Simulation of LRU algorithm: \n");
  for (int i = 0; i < PAGE_REF_LEN; ++i) {
    // check whether current page is in the page frames
    if (in_page_frames[page_ref[i]]) {
      // update the last_used even though it is already in the page frame
      last_used[page_ref[i]] = i;
      continue;
    }
    ++page_faults;
    
    // get idx for replacement
    idx = lru_get_idx(page_frames, n, last_used);

    // update
    if (page_frames[idx] != -1) {
      in_page_frames[page_frames[idx]] = 0;
    }
    page_frames[idx] = page_ref[i];
    in_page_frames[page_ref[i]] = 1;
    last_used[page_ref[i]] = i;

    printf("page_frames: ");
    for (int i = 0; i < n; ++i) {
      printf("%d ", page_frames[i]);
      if (i == n - 1) printf("\n");
    }
  }

  printf("page_fault = %d\n\n", page_faults);
}

void fifo(int n) {
  // init page_frames
  int page_frames[n];
  for (int i = 0; i < n; ++i) {
    page_frames[i] = -1;
  }

  // init in_page_frames
  int in_page_frames[MAX_PAGE_NUM + 1];
  for (int i = 0; i < MAX_PAGE_NUM + 1; ++i) {
    in_page_frames[i] = 0;
  }

  // simulate the page replacement and count page faults
  int page_faults = 0, idx = 0;
  printf("Simulation of FIFO algorithm: \n");
  for (int i = 0; i < PAGE_REF_LEN; ++i) {
    // check whether current page is in the page frames
    if (in_page_frames[page_ref[i]]) {
      continue;
    }
    ++page_faults;

    // update
    if (page_frames[idx] != -1) {
      in_page_frames[page_frames[idx]] = 0;
    }
    page_frames[idx++] = page_ref[i];
    idx %= n;
    in_page_frames[page_ref[i]] = 1;

    printf("page_frames: ");
    for (int i = 0; i < n; ++i) {
      printf("%d ", page_frames[i]);
      if (i == n - 1) printf("\n");
    }
  }

  printf("page_fault = %d\n\n", page_faults);
}

int main(int argc, char* argv[]) {
  // parse the argument
  int n;
  if (argc != 2) {
    help();
    exit(0);
  }
  if (sscanf(argv[1], "%d", &n) != 1 || (n < 1 || n > 7)) {
    printf("ERROR: Invalid argument.\n\n");
    help();
    exit(0);
  }
  
  // randomize page ref string with page num 0 to 9
  srand(time(NULL));
  printf("page_ref: ");
  for (int i = 0; i < PAGE_REF_LEN; ++i) {
    page_ref[i] = rand() % 10;
    while (page_ref[i] == page_ref[i - 1]) {
      page_ref[i] = rand() % 10; // no duplicate
    }
    printf("%d ", page_ref[i]);
    if (i == PAGE_REF_LEN - 1) printf("\n\n");
  }

  // call lru
  lru(n);

  // call fifo
  fifo(n);

  return 0;
}