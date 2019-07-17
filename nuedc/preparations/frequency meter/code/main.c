#include "lcd1602.h"
#include "reg52.h"
#include <stdio.h>
#include <string.h>

typedef unsigned int u16;
typedef unsigned char u8;
typedef unsigned long u32;

u8 frequency_show[16];
u32 frequency;
u8 frequency_integer_counter;

u8 ct;

void Delay_10ms(u8 t)  //误差 0us   延时t*10ms  晶振12MHz 实际晶振并不能达到12MHz
{
    u8 a,b;
    for(;t>0;t--)
        for(b=38;b>0;b--)
            for(a=130;a>0;a--);
}

void Timer1Counter0_Init()  // 计数器0 定时器1
{
	TMOD |= 0x15;   //模式选择
	TH0 = 0x00;
	TL0 = 0x00;
//	TH1 = 0x0B; 	// 定时器1 产生 1s定时 12M 0x0BDC
//	TL1 = 0xDC;
	
	TH1 = 0x1f;
	TL1 = 0x99;
	
	EA = 1;				// 开中断
	ET1 = 1;
	ET0 = 1;
	TR0 = 1;
	TR1 = 1;
}

/*
u16 decode_frequency(u8 th, u8 tl)
{
	u16 tmp = th*256 + tl;
	return tmp;
}
*/

void main()
{
	ct = 0;
	frequency = 0;
	frequency_integer_counter = 0;
	LCD_Init();
	LCD_Clear();
	Timer1Counter0_Init();
	while(1)
	{
		while(ct < 16)
			; // 等待中断
		//frequency = decode_frequency(TH0, TL0);
		frequency = TH0*256 + TL0 + frequency_integer_counter*65536;
		sprintf(frequency_show, "F: %lu", frequency);
		LCD_Write_String(0, 0, frequency_show);
		LCD_Write_String(13,0, "Hz");
		Delay_10ms(100);
		// 初始化
		ct = 0;
		frequency = 0;
		frequency_integer_counter = 0;
		LCD_Clear();
		LCD_Clear();
		memset(frequency_show,0,sizeof(frequency_show));
		memset(frequency_show,0,sizeof(frequency_show));
		TH0 = 0x00;
		TL0 = 0x00;
		TH1 = 0x1F; 	// 定时器1 产生 1s定时 T1 = 0BDC;
		TL1 = 0x99;
		
		TR0 = 1;
		TR1 = 1;

	}
}

// 计数器 先测试不超过 65536Hz 的信号
void Counter0() interrupt 1
{
	frequency_integer_counter++;
}

void Timer1() interrupt 3
{
	TH1 = 0x1F; 	// 定时器1 产生 1s定时
	TL1 = 0x99;
	ct++;
	if(ct==16)
	{
		TR1 = 0; // 16次 定时满 1s
		TR0 = 0; // 计数停止
	}
}

