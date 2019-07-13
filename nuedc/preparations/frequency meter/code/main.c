#include "reg52.h"

typedef unsigned int u16; // 16λ����
typedef unsigned char u8; // 8λ����
typedef unsigned long u32; //32λ����

sbit led = P0^0;

u8 frequency_integer_counter = 0x00; //�����������˼���
u8 ct = 0;
u32 frequency = 0;

u8 code Segment_CAnode[] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
								// ��0��9 ������
// Segment_CCathode[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f}		
	// ��0��9 ������


/*
* i = 1 ��ʱ10us����
*
*/
void delay(u16 i)
{
	while(i--);	
}

/********** ��̬�������ʾ **********************
�� para: index:��ʾ������		select:ѡ��������
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
* ��ʱ��0�ͼ�����1��ʼ��
* para		None
* return	None
***********************************************/
void Timer0Counter1Init()
{
	TMOD |= 0x51; // ������1 Gata���� 16λ		��ʱ��0 Gate�ر� 16λ
	
	// Timer0 ѭ��16�� ÿ�μ�ʱ1/16�� һ�������62500�� �ʳ�ֵΪ3036
	TH0 = 0x0B;
	TL0 = 0xDC;
	// Counter1
	TH1 = 0x00;
	TL1 = 0x00;	
	EA = 1; // ���ж����� ��Ҫ�ж��� Ӧ����Ҫ ������1��Ҫ�ж�
	ET1 = 1;
	ET0 = 1;
}
	
void main()
{
	Timer0Counter1Init(); // ��ʼ��
	while(1)
	{
		TR0 = 1;						//�򿪶�ʱ��0
		TR1 = 1;						//�򿪼�����1
		while(ct < 16)			//��ʱ��ѭ������
			;
		frequency |= TH1;
		frequency = (frequency<<8) | TL0;
		frequency += frequency_integer_counter*65536;
		
		smgshow(1, frequency/100); //�Ȳ���100Hz�����
		smgshow(2, (frequency-(frequency/100)*100)/10);
		smgshow(3, frequency%10);
	}
}

// ��ʱ���жϷ����Ӻ���
void Time0() interrupt 1
{
	// �ŵ��ж����� ��������˵�ǲ�����ʱ���
	TH0 = 0x0B;
	TL0 = 0xDC;
	ct++;
	if(ct==16)
		TR1 = 0;  //������ʱ�� �ر�Counter1����
}

// �������жϷ����Ӻ���
void Counter1() interrupt 3
{
	TH1 = 0x00;
	TL1 = 0x00;	
	frequency_integer_counter++;
}