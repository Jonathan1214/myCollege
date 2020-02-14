#include <stdlib.h>
#include "linearListOrder.h"

// 构造一个空的线性链表
Status InitList_Sq()
{
    SqList *L;
    L->elem = (ElemType *)malloc(LIST_INIT_SIZE * sizeof(ElemType));// L 为指针
    if (!L->elem) exit(OVERFLOW);
    L->length = 0;
    L->listsize = LIST_INIT_SIZE;
    return OK;
} // InitList_Sq
