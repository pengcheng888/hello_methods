#include "mylib.h"
#include "stdio.h"
int main(int argc, char **argv)
{
  int res = mylib::add(3, 4);
  printf("test_mylib %d\n", res);
}