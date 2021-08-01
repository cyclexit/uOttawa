# Module 5 - Process Synchronization (Chapter 6 and 7)

## Critical Section
Each process has a segment of code, called a **critical section**,
in which the process may be accessing — and updating — data that is shared with at least one other process.

### Critical Section Problem
The **critical-section problem** is to design a *protocol* that the processes can use to synchronize their activity so as to cooperatively share data. Each process must request permission to enter its critical section. The section of code implementing this request is the **entry section**. The critical section may be followed by an **exit section**. The remaining code is the **remainder section**. </br>

* Criteria for a valid solution
    1. **Mutual exclusion**: At any time, at most one thread can be in a critical section.
    2. **Progress**
        * no deadlock;
        * no interference: if a thread stops in its remaining section, this     should not affect other threads;
        * assume that a thread which enters a critical section will leave   it;
        * if a thread requests to enter a critical section at a time when   no other thread requests it, it should be able to enter it.
    3. **Bounded waiting**: no thread eternally prevented from reaching its     critical section (no starvation).
* Types of solutions </br>
All solutions below are based on **atomic access to main memory**, i.e., memory at a specific address can only be affected by one instruction at a time, and thus one thread/process at a time. More generally, all solutions are based on the existence of **atomic instructions**, that operate as basic CSs.
    1. Software solutions
        * algorithms whose correctness does not rely on any other assumptions, e.g., Peterson’s algorithm
    2. Hardware solutions
        * rely on some special machine instructions, e.g., testAndSet, xchng.
    3. OS provided solutions (Used nowadays)
        * higher level primitives (implemented usually using the hw solutions) provided for convenience by the OS/library/language, e.g., semaphores, monitors
* **Peterson's algorithm**: Peterson’s solution is <u> restricted to two processes </u> that alternate execution between their critical sections and remainder sections.
    ```cpp
    // i denotes the current process
    // j denotes the other process, and j = 1 - i

    int turn; // use turnto let the other task enter the CS
    bool flag[2]; // Use the flag[i] to indicate willingness to enter CS
    while (true) {
      flag[i] = true;
      turn = j;
      while (flag[j] && turn == j) {
        // waiting
      }
      /* critical section */
      flag[i] = false;
      /* remainder section */
    }
    ```
    * **Note**: The Peterson algorithm can be generalised to more than 2 tasks, but there exists other more elegant algorithms – the banker’s algorithm.
    * **Problem**: Threads that require entry into their CS are **busy waiting**; thus, consuming CPU time.
* **Test-and-set**
    ```cpp
    bool test_and_set(bool* target) {
      bool ret = *target;
      *target = true;
      return ret;
    }

    do {
      while (test_and_set(&lock)) {
          // waiting
      }
      /* critical section */
      lock = false;
      /* remainder section */
    } while (true);
    ```
    * **Problem**: still use busy waiting; no limit on waiting, so starvation is possible
* **Semaphore**
    * A semaphore S is an integer which, except for initialization, is accessible only by these 2 operations which are atomic and mutually exclusive: `wait(S)` and `signal(S)`.
    * Types of semaphores
        * semaphores which are busy waiting </br>
            semaphores that use waiting queues
        * counter semaphores </br>
            binary semaphores
    * **Problem**: starvation; deadlock.
* **Monitor**
    * Monitor is a module containing:
        * one or more procedures
        * an initialization sequence
        * local variables
    * Features about monitor:
        * local variables accessible only by using a monitor procedure
        * a thread enters the monitor by invoking one of its procedures
        * only one thread can execute in the monitor at any moment 
