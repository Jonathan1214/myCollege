#include "reg52.h"
#include "lcd1602.h"
#include <stdio.h>
#include <string.h>

typedef unsigned int u16; // 16λ����
typedef unsigned char u8; // 8λ����
typedef unsigned long u32; //32λ����

u8 frequency_integer_counter = 0; //�����������˼���
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

void Delay_10ms(u8 t)   //��� 0us   ��ʱt*10ms  ����12MHz ʵ�ʾ��񲢲��ܴﵽ12MHz
{
    u8 a,b;
    for(;t>0;t--)
        for(b=38;b>0;b--)
            for(a=130;a>0;a--);
}
/***********************************************
* Timer0Counter1Init
* ��ʱ��0�ͼ�����1��ʼ��
* para		None
* return	None
***********************************************/
void Timer0Counter1Init()
{
	TMOD |= 0x51; // ��ʱ��1 Gata���� 16λ		��ʱ��0 Gate�ر� 16λ
	
	// Timer0 ѭ��16�� ÿ�μ�ʱ1/16�� һ�������62500�� �ʳ�ֵΪ3036
	TH0 = 0x0B;
	TL0 = 0xDC;
	// Counter1
	TH1 = 0x00;
	TL1 = 0x00;	
	EA = 1; // ���ж����� ��Ҫ�ж��� Ӧ����Ҫ ������1��Ҫ�ж�
	ET1 = 1;
	ET0 = 1;
	//TR0 = 1;						//�򿪶�ʱ��0
	//TR1 = 1;						//�򿪶�ʱ��1
}

void main()
{
	Timer0Counter1Init(); // ��ʼ����������ʱ��
	LCD_Init();						// ��ʼ��LCD
	LCD_Clear();					// ����
	while(1)
	{
		TH1 = 0x00;
		TL1 = 0x00;
		
		TH0 = 0x1F;
		TL0 = 0x86;
		
		TR0 = 1;						//�򿪶�ʱ��0
		TR1 = 1;						//�򿪼�����1
		

		while(ct < 16)			//��ʱ��0ѭ������
			;
		//TR0 = 0;
		//TR1 = 0;
		//frequency |= TH1;
		//frequency = (frequency<<8) | TL1;
		//frequency = frequency_integer_counter*65536 + TL1 + TH1*256; // ת��
		frequency = TL1 + TH1*256 + frequency_integer_counter*65536;
		
/*		if (frequency > 500)
			LCD_Write_String(4,0,"SUCCESS");
		else
			LCD_Write_String(4,0,"FAIL");
		*/
		
		sprintf(frequency_show, "f: %u Hz",frequency);
		LCD_Write_String(0,0,frequency_show);
		Delay_10ms(100);			// ��ʱ3s Ӧ��û����ô��ʱ��
		frequency = 0;
		ct = 0;								// ѭ��������0
		//memset(frequency_show,0,sizeof(frequency_show)); // ��� ���о���ʵû�б�Ҫ
		LCD_Clear();
	}
}

// ��ʱ��0�жϷ����Ӻ���
void Time0() interrupt 1
{
	// �ŵ��ж����� ��������˵�ǲ�����ʱ���
	TH0 = 0x1F;
	TL0 = 0x86;
	ct++;
	if(ct==16)
	{
		TR1 = 0;  //������ʱ�� �ر�Counter1����
		TR0 = 0;
	}
}

// ��ʱ��1�жϷ����Ӻ���
void Counter1() interrupt 3
{	
	frequency_integer_counter++;
}