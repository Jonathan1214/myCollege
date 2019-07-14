#include "reg52.h"
#include "lcd1602.h"
#include <stdio.h>
#include <string.h>

typedef unsigned int u16; // 16位数据
typedef unsigned char u8; // 8位数据
typedef unsigned long u32; //32位数据

u8 frequency_integer_counter = 0; //计数器记满了几次
u8 ct = 0;
//u32 frequency = 0;
u16 frequency = 0;
u8 frequency_show[16];

/*
u8 number[] = "0123456789";
u8 hund = 0;
u8 dec = 0;
u8 single = 0;
*/

void Delay_10ms(u8 t)   //误差 0us   延时t*10ms  晶振12MHz 实际晶振并不能达到12MHz
{
    u8 a,b;
    for(;t>0;t--)
        for(b=38;b>0;b--)
            for(a=130;a>0;a--);
}
/***********************************************
* Timer0Counter1Init
* 定时器0和计数器1初始化
* para		None
* return	None
***********************************************/
void Timer0Counter1Init()
{
	TMOD |= 0x51; // 定时器1 Gata开启 16位		定时器0 Gate关闭 16位
	
	// Timer0 循环16次 每次计时1/16秒 一共需计数62500个 故初值为3036
	TH0 = 0x0B;
	TL0 = 0xDC;
	// Counter1
	TH1 = 0x00;
	TL1 = 0x00;	
	EA = 1; // 总中断允许 需要中断吗 应该需要 计数器1需要中断
	ET1 = 1;
	ET0 = 1;
	//TR0 = 1;						//打开定时器0
	//TR1 = 1;						//打开定时器1
}

void main()
{
	Timer0Counter1Init(); // 初始化计数器定时器
	LCD_Init();						// 初始化LCD
	LCD_Clear();					// 清屏
	while(1)
	{
		TH1 = 0x00;
		TL1 = 0x00;
		
		TH0 = 0x1F;
		TL0 = 0x86;
		
		TR0 = 1;						//打开定时器0
		TR1 = 1;						//打开计数器1
		

		while(ct < 16)			//定时器0循环次数
			;
		//TR0 = 0;
		//TR1 = 0;
		//frequency |= TH1;
		//frequency = (frequency<<8) | TL1;
		//frequency = frequency_integer_counter*65536 + TL1 + TH1*256; // 转换
		frequency = TL1 + TH1*256 + frequency_integer_counter*65536;
		
/*		if (frequency > 500)
			LCD_Write_String(4,0,"SUCCESS");
		else
			LCD_Write_String(4,0,"FAIL");
		*/
		
		sprintf(frequency_show, "f: %u Hz",frequency);
		LCD_Write_String(0,0,frequency_show);
		Delay_10ms(100);			// 延时3s 应该没有这么长时间
		frequency = 0;
		ct = 0;								// 循环计数清0
		//memset(frequency_show,0,sizeof(frequency_show)); // 清吧 但感觉其实没有必要
		LCD_Clear();
	}
}

// 定时器0中断服务子函数
void Time0() interrupt 1
{
	// 放到中断里面 理论上来说是不消耗时间的
	TH0 = 0x1F;
	TL0 = 0x86;
	ct++;
	if(ct==16)
	{
		TR1 = 0;  //结束定时了 关闭Counter1计数
		TR0 = 0;
	}
}

// 定时器1中断服务子函数
void Counter1() interrupt 3
{	
	frequency_integer_counter++;
}