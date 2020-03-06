#ifndef __LINEAR_LIST_ORDER_H__
#define __LINEAR_LIST_ORDER_H__
#include "../data_defination.h"
typedef int ElemType; // 用int作数据类型
#define LIST_INIT_SIZE 100 //初始化长度
#define LISTINCREMENT 10 //增量
typedef struct
{
    ElemType *elem; //存储空间基址
    int length;
    int listsize;
}SqList;    // Sequence List
//操作定义
Status InitList_Sq();

#endif