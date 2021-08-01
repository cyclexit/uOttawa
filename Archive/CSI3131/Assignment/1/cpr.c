/* ------------------------------------------------ ------------
File: cpr.c

Last name: Lin
Student number: 300053082

Last name: Retanal
Student number: 300052309

Description: This program contains the code for creation
 of a child process and attach a pipe to it.
   The child will send messages through the pipe
   which will then be sent to standard output.

Explanation of the zombie process
(point 5 of "To be completed" in the assignment):
  
  The zombie process is marked as "[cpr] <defunct>" in the print of the command
  "ps -ef | grep cpr". This zombie process exists during the whole running time
  of the program, and it is released until the program exit. In other words,
  this zombie process wastes the memory during the running of the program.

------------------------------------------------------------- */
#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>

/* Prototype */
void createChildAndRead(int);

/* -------------------------------------------------------------
Function: main
Arguments: 
  int ac	- number of command arguments
  char **av - array of pointers to command arguments
Description:
  Extract the number of processes to be created from the
  Command line. If an error occurs, the process ends.
  Call createChildAndRead to create a child, and read
  the child's data.
-------------------------------------------------- ----------- */

int main(int ac, char **av) {
  int processNumber; 
  
  if (ac == 2) {
    if (sscanf(av[1], "%d", &processNumber) == 1) {
      createChildAndRead(processNumber);
    } else {
      fprintf(stderr, "Cannot translate argument\n");
    }
  } else {
    fprintf(stderr, "Invalid arguments\n");
  }

  return 0;
}


/* ------------------------------------------------ -------------
Function: createChildAndRead
Arguments: 
  int prcNum - the process number
Description:
  Create the child, passing prcNum-1 to it. Use prcNum
  as the identifier of this process. Also, read the
  messages from the reading end of the pipe and sends it to 
  the standard output (df 1). Finish when no data can
  be read from the pipe.
-------------------------------------------------- ----------- */

void createChildAndRead(int prcNum) {
  /* Please complete this function according to the
  Assignment instructions. */

  if (prcNum == 1) {
    printf("Process %d begins\n", prcNum);
    fflush(stdout);
    sleep(5);
    printf("Process %d ends\n", prcNum);
    fflush(stdout);
  } else {
    printf("Process %d begins\n", prcNum);
    fflush(stdout);

    // create pipes
    int pipe_fd[2];
    if (pipe(pipe_fd) == -1) {
      fprintf(stderr, "Failed to create pipes\n");
      return;
    }

    // create child process
    int pid = fork();
    if (pid == -1) {
      fprintf(stderr, "Failed to fork\n");
      return;
    }
    if (pid == 0) { // child
      close(pipe_fd[0]);
      dup2(pipe_fd[1], STDOUT_FILENO);
      char* file = "./cpr";
      char pn[20];
      sprintf(pn, "%d", prcNum - 1);
      char* cmd[3] = {"cpr", pn, NULL};
      execvp(file, cmd);
    } else { // parent
      close(pipe_fd[1]);
      char buf;
      while (read(pipe_fd[0], &buf, 1) > 0) {
        write(STDOUT_FILENO, &buf, 1);
      }
      close(pipe_fd[0]);
      printf("Process %d ends\n", prcNum);
      fflush(stdout);

      sleep(10); // create a delay
    }
  }
}
