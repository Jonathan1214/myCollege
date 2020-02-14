#include <stdio.h>
#include <stdlib.h>
#include "linearListOrder.h"

int main()
{
    Status init_st = InitList_Sq();
    printf("InitStatus %d", init_st);
    return 0;
}