#include "lcd1602.h"
#include <intrins.h>

/*
bit LCD_Check_Busy()
{
	RS_CLR;
	RW_SET;
	EN_CLR;
	_nop_();
	EN_SET;
	return (bit)(LCD_DataPort & 0x80);
} */

void LCD1602_Delay1ms(unsigned int c)   //��� 0us
{
  unsigned char a,b;
	for (; c>0; c--)
		 for (b=199;b>0;b--)
		  	for(a=1;a>0;a--); 	
}

// д����
void LCD_Write_Com(unsigned char com)
{
	//while(LCD_Check_Busy());
	RS_CLR;
	RW_CLR;
	EN_SET;
	LCD_DataPort = com;
	//_nop_();
	LCD1602_Delay1ms(2);
	EN_CLR;
}

//д����
void LCD_Write_Data(unsigned char dat)
{
	//while(LCD_Check_Busy());
	RS_SET;
	RW_CLR;
	EN_SET;
	LCD_DataPort = dat;
	//_nop_();
	LCD1602_Delay1ms(2);
	EN_CLR;
}

/*************д�ַ���***************
* xΪ�ַ���ʵλ��
* yΪ��λ�� ֵΪ0��1 ѡ���1�л��ߵ�2��
*
************************************/
void LCD_Write_String(unsigned char x, unsigned char y, unsigned char *s)
{
	if(y) // �ڶ���
		LCD_Write_Com(0xC0+x);
	else
		LCD_Write_Com(0x80+x);
	
	while(*s)
	{
		LCD_Write_Data(*s);
		s++;
	}
}

/**************д�ַ�*****************
* ͬ��
*
*************************************/
void LCD_Write_Char(unsigned char x, unsigned char y, unsigned char dat)
{
	if(y) // �ڶ���
		LCD_Write_Com(0xC0+x);
	else
		LCD_Write_Com(0x80+x);
	LCD_Write_Data(dat);
}

// ��ʼ��
void LCD_Init()
{
	//LCD_Write_Com(0x38);  //����ʾ
	//LCD1602_Delay1ms(2);
	//LCD_Write_Com(0x38);  //����ʾ
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x38);  //����ʾ
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x38);
	LCD_Write_Com(0x08);  // ��ʾ�ر�
	LCD_Write_Com(0x01);	//����
	LCD_Write_Com(0x06);  //��ʾһ�����+1
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x0C);  // ����ʾ���������
}
	
//����
void LCD_Clear()
{
	LCD_Write_Com(0x01);
	LCD1602_Delay1ms(1);
}
