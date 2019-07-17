#ifndef __LCD_H_
#define __LCD_H_

#include "reg52.h"

/*
#ifndef u8
#define u8 unsigned char
#endif

#ifndef u16
#define u16 unsigned int
#endif
*/

/**** PIN 口定义 *******/
#define LCD_DataPort P0

// 引脚定义 亚博
sbit LCD1602_RS = P1^0;
sbit LCD1602_RW = P1^1;
sbit LCD1602_EN = P2^5;

/*
// TX
sbit LCD1602_RS = P3^5;
sbit LCD1602_RW = P1^1;
sbit LCD1602_EN = P3^4;
*/

#define RS_CLR LCD1602_RS=0			//命令输入
#define RS_SET LCD1602_RS=1			//数据输入

#define RW_CLR LCD1602_RW=0			//写
#define RW_SET LCD1602_RW=1			//读

#define EN_CLR LCD1602_EN=0			//关闭使能
#define EN_SET LCD1602_EN=1			//使能开启

/*判忙*/
// bit LCD_Check_Busy();

/*在51单片机12MHZ时钟下的延时函数*/
void LCD1602_Delay1ms(unsigned int c);   //误差 0us

/*LCD1602写入8位命令子函数*/
void LCD_Write_Com(unsigned char com);

/*LCD1602写入8位数据子函数*/	
void LCD_Write_Data(unsigned char dat);

//写入字符串
void LCD_Write_String(unsigned char x, unsigned char y, unsigned char *s);

//写入字符
void LCD_Write_Char(unsigned char x, unsigned char y, unsigned char dat);

/*LCD1602初始化子程序*/		
void LCD_Init();				

/*LCD1602清屏*/
void LCD_Clear();

#endif
