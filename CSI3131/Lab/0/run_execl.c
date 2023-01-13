#include <unistd.h>

int main() {
  char* path = "/bin/ls";
  char* arg1 = "-lh";
  char* arg2 = "/home";
  execl(path, arg1, arg2); // without NULL more info will be printed
  return 0;
}