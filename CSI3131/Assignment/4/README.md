# CSI3131 Assignment 4

## Memeber
* Hongyi Lin, 300053082
* Rodger Retanal, 300052309

## Introduction
For this assignment, the solutions are in the folder `q1`, `q2` and `q3` respectively for 3 questions.
* In `q1` folder, there will be a PDF `Q1.pdf`.
* In `q2` folder, there should be `page_replace.c` and `Makefile`.
* In `q3` folder, there should be `shm_utils.h`, `shm_utils.c`, `catalan_producer.c`, `catalan_consumer.c` and `shm_delete.c`.

For question 2 and 3, please test it with **Linux** environment.

## Usage
### Question 1
Just see the solution in the PDF.

### Question 2
In `page_replace.c`, we implement the `LRU` and `FIFO` page replacement algorithm. Simply use command `make` to compile the source code. Then, use the generated executable `page_replace` to verify the result. You can change the value of the macro `PAGE_REF_LEN` to change the length of the page reference string.
```bash
# n is the number of page frames
# n should be in the range [1, 7]
./page_replace n
```

### Question 3
`shm_utils.h` contains the function prototypes for share memory usage, and `shm_utils.c` contains the implementations. <br>

Simply use `make` command to compile the source code. After the compilation, three executables are expected. They are `catalan_producer.out`, `catalan_consumer.out` and `shm_delete.out`.
* `catalan_producer.out` is used to generate catalan numbers and write them to the shared memory.
    ```bash
    # n is the length of the catalan sequence.
    # DO NOT make n too large!
    # In our system, n can be as large as 33.
    # When n is bigger than 33, there will an overflow since the result is too big to be represented even by long long type.
    ./catalan_producer.out n
    ```
* `catalan_consumer.out` is used to read the data in the shared memory created by the producer. No argument is needed.
    ```bash
    ./catalan_consumer.out
    ```
* `shm_delete.out` is used to delete the shared memory created by the producer. No argument is needed.
    ```bash
    ./shm_delete.out
    ```