#include "reg52.h"

typedef unsigned int u16; // 16位数据
typedef unsigned char u8; // 8位数据
typedef unsigned long u32; //32位数据

sbit led = P0^0;

u8 frequency_integer_counter = 0x00; //计数器记满了几次
u8 ct = 0;
u32 frequency = 0;

u8 code Segment_CAnode[] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
								// 从0到9 共阳型
// Segment_CCathode[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f}		
	// 从0到9 共阴极


/*
* i = 1 延时10us左右
*
*/
void delay(u16 i)
{
	while(i--);	
}

/********** 动态数码管显示 **********************
× para: index:显示的数字		select:选择的数码管
* return: None
***********************************************/
void smgshow(u8 select, u8 index)
{
	P2 = select;
	P0 = Segment_CAnode[index];
	delay(100);
}

/***********************************************
* Timer0Counter1Init
* 定时器0和计数器1初始化
* para		None
* return	None
***********************************************/
void Timer0Counter1Init()
{
	TMOD |= 0x51; // 计数器1 Gata开启 16位		定时器0 Gate关闭 16位
	
	// Timer0 循环16次 每次计时1/16秒 一共需计数62500个 故初值为3036
	TH0 = 0x0B;
	TL0 = 0xDC;
	// Counter1
	TH1 = 0x00;
	TL1 = 0x00;	
	EA = 1; // 总中断允许 需要中断吗 应该需要 计数器1需要中断
	ET1 = 1;
	ET0 = 1;
}
	
void main()
{
	Timer0Counter1Init(); // 初始化
	while(1)
	{
		TR0 = 1;						//打开定时器0
		TR1 = 1;						//打开计数器1
		while(ct < 16)			//定时器循环次数
			;
		frequency |= TH1;
		frequency = (frequency<<8) | TL0;
		frequency += frequency_integer_counter*65536;
		
		smgshow(1, frequency/100); //先测试100Hz级别的
		smgshow(2, (frequency-(frequency/100)*100)/10);
		smgshow(3, frequency%10);
	}
}

// 定时器中断服务子函数
void Time0() interrupt 1
{
	// 放到中断里面 理论上来说是不消耗时间的
	TH0 = 0x0B;
	TL0 = 0xDC;
	ct++;
	if(ct==16)
		TR1 = 0;  //结束定时了 关闭Counter1计数
}

// 计数器中断服务子函数
void Counter1() interrupt 3
{
	TH1 = 0x00;
	TL1 = 0x00;	
	frequency_integer_counter++;
}