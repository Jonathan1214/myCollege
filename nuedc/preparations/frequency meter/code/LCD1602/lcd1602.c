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

void LCD1602_Delay1ms(unsigned int c)   //误差 0us
{
  unsigned char a,b;
	for (; c>0; c--)
		 for (b=199;b>0;b--)
		  	for(a=1;a>0;a--); 	
}

// 写命令
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

//写数据
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

/*************写字符串***************
* x为字符其实位置
* y为行位置 值为0或1 选择第1行或者第2行
*
************************************/
void LCD_Write_String(unsigned char x, unsigned char y, unsigned char *s)
{
	if(y) // 第二行
		LCD_Write_Com(0xC0+x);
	else
		LCD_Write_Com(0x80+x);
	
	while(*s)
	{
		LCD_Write_Data(*s);
		s++;
	}
}

/**************写字符*****************
* 同上
*
*************************************/
void LCD_Write_Char(unsigned char x, unsigned char y, unsigned char dat)
{
	if(y) // 第二行
		LCD_Write_Com(0xC0+x);
	else
		LCD_Write_Com(0x80+x);
	LCD_Write_Data(dat);
}

// 初始化
void LCD_Init()
{
	//LCD_Write_Com(0x38);  //开显示
	//LCD1602_Delay1ms(2);
	//LCD_Write_Com(0x38);  //开显示
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x38);  //开显示
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x38);
	LCD_Write_Com(0x08);  // 显示关闭
	LCD_Write_Com(0x01);	//清屏
	LCD_Write_Com(0x06);  //显示一个光标+1
	LCD1602_Delay1ms(2);
	LCD_Write_Com(0x0C);  // 开显示及光标设置
}
	
//清屏
void LCD_Clear()
{
	LCD_Write_Com(0x01);
	LCD1602_Delay1ms(1);
}
