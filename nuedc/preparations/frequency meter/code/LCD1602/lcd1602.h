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

/**** PIN �ڶ��� *******/
#define LCD_DataPort P0

// ���Ŷ��� �ǲ�
sbit LCD1602_RS = P1^0;
sbit LCD1602_RW = P1^1;
sbit LCD1602_EN = P2^5;

/*
// TX
sbit LCD1602_RS = P3^5;
sbit LCD1602_RW = P1^1;
sbit LCD1602_EN = P3^4;
*/

#define RS_CLR LCD1602_RS=0			//��������
#define RS_SET LCD1602_RS=1			//��������

#define RW_CLR LCD1602_RW=0			//д
#define RW_SET LCD1602_RW=1			//��

#define EN_CLR LCD1602_EN=0			//�ر�ʹ��
#define EN_SET LCD1602_EN=1			//ʹ�ܿ���

/*��æ*/
// bit LCD_Check_Busy();

/*��51��Ƭ��12MHZʱ���µ���ʱ����*/
void LCD1602_Delay1ms(unsigned int c);   //��� 0us

/*LCD1602д��8λ�����Ӻ���*/
void LCD_Write_Com(unsigned char com);

/*LCD1602д��8λ�����Ӻ���*/	
void LCD_Write_Data(unsigned char dat);

//д���ַ���
void LCD_Write_String(unsigned char x, unsigned char y, unsigned char *s);

//д���ַ�
void LCD_Write_Char(unsigned char x, unsigned char y, unsigned char dat);

/*LCD1602��ʼ���ӳ���*/		
void LCD_Init();				

/*LCD1602����*/
void LCD_Clear();

#endif
