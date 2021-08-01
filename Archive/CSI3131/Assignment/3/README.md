# CSI3131 Assignment 3

## Memeber
* Hongyi Lin, 300053082
* Rodger Retanal, 300052309

## Introduction
We solve this assignment with `pthread` library and POSIX `semaphore`, so please test it with **Linux** environment.

## Usage
There is a Makefile in the directory. Simply use the command `make` to compile `sol.c`. </br>
</br>

After `sol.c` is compiled, you will get the executable `sol` in the same directory with the source code. Then, you can use this executable to observe the output. </br>
</br>

The program will keep running until any key is pressed. After pressing any key, all threads will be joined and all resources will be released.</br>
</br>

**WARNING**: Please DO NOT use `ctrl+c` to terminate the program, since the program cannot have a clean exit in this way.
