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

void Delay_10ms(u8 t)  //��� 0us   ��ʱt*10ms  ����12MHz ʵ�ʾ��񲢲��ܴﵽ12MHz
{
    u8 a,b;
    for(;t>0;t--)
        for(b=38;b>0;b--)
            for(a=130;a>0;a--);
}

void Timer1Counter0_Init()  // ������0 ��ʱ��1
{
	TMOD |= 0x15;   //ģʽѡ��
	TH0 = 0x00;
	TL0 = 0x00;
//	TH1 = 0x0B; 	// ��ʱ��1 ���� 1s��ʱ 12M 0x0BDC
//	TL1 = 0xDC;
	
	TH1 = 0x1f;
	TL1 = 0x99;
	
	EA = 1;				// ���ж�
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
			; // �ȴ��ж�
		//frequency = decode_frequency(TH0, TL0);
		frequency = TH0*256 + TL0 + frequency_integer_counter*65536;
		sprintf(frequency_show, "F: %lu", frequency);
		LCD_Write_String(0, 0, frequency_show);
		LCD_Write_String(13,0, "Hz");
		Delay_10ms(100);
		// ��ʼ��
		ct = 0;
		frequency = 0;
		frequency_integer_counter = 0;
		LCD_Clear();
		LCD_Clear();
		memset(frequency_show,0,sizeof(frequency_show));
		memset(frequency_show,0,sizeof(frequency_show));
		TH0 = 0x00;
		TL0 = 0x00;
		TH1 = 0x1F; 	// ��ʱ��1 ���� 1s��ʱ T1 = 0BDC;
		TL1 = 0x99;
		
		TR0 = 1;
		TR1 = 1;

	}
}

// ������ �Ȳ��Բ����� 65536Hz ���ź�
void Counter0() interrupt 1
{
	frequency_integer_counter++;
}

void Timer1() interrupt 3
{
	TH1 = 0x1F; 	// ��ʱ��1 ���� 1s��ʱ
	TL1 = 0x99;
	ct++;
	if(ct==16)
	{
		TR1 = 0; // 16�� ��ʱ�� 1s
		TR0 = 0; // ����ֹͣ
	}
}

