%ֱ�ߵ�ɶԵĵ糡�ߺ͵�����(�ȸ��߷������߷�)
clear,lambda=input('�������ɱ�:');    %���������ɱ�
xm=2.5;x=linspace(-xm,xm);             %x���귶Χ�ͺ���������
ym=2;y=linspace(0,ym);                 %y���귶Χ������������
y(1)=eps;  %���ΪСֵ
[X,Y]=meshgrid(x,y);                   %������������
R1=sqrt((X+1).^2+Y.^2);                %��һ��(��)��ɵ�����ľ���
R2=sqrt((X-1).^2+Y.^2);                %�ڶ�����ɵ�����ľ���
U=2.*(log(1./R1)+lambda.*log(1./R2));	   %�������
u=-3:0.5:3;                            %��������
C=contour(X,Y,U,u,'LineWidth',2);clabel(C,'FontSize',10); %����������߲�ȡ����,��ǵ����ߵ�ֵ
grid on,axis equal,hold on
contour(X,-Y,U,u,'LineWidth',2)	       %�����������
plot([-xm;xm],[0;0],[0;0],[-ym;ym],'LineWidth',2)%��ˮƽ�ߺ���ֱ��

C=atan((X+1)./Y)+lambda*atan((X-1)./Y);%����糡�߳���
r0=0.1;                                %�糡�����뾶
dth=20;                                %��һ����ɵ���ʼ�Ǻͼ��
th=dth:dth:180-dth;                    %�Ƕ�����
th=th*pi/180;                          %��Ϊ����
x0=r0*cos(th)-1;                       %��������
y0=r0*sin(th);                         %���������
c=atan((x0+1)./y0)+lambda*atan((x0-1)./y0);%����ȸ��߳���
contour(X,Y,C,c,'b','LineWidth',2)     %�������ֵ��(�糡��)
contour(X,-Y,C,c,'b','LineWidth',2)    %�������ֵ��(�糡��)
title('ֱ�ߵ�ɵĵ糡�ߺ͵�����','FontSize',12)%��ʾ����
xlabel('\itx/a','FontSize',12),ylabel('\ity/a','FontSize',12)
txt=['���Ƶ�λ:\itk\lambda\rm_1,����ܶȱ�:',num2str(lambda)];%�����ı�
text(-xm,ym-0.5,txt,'FontSize',12)     %��ǵ����ı�

Ey=Y.*(R2.^2+lambda*R1.^2);            %��ǿ��y����
Ex=(X+1).*R2.^2+lambda*(X-1).*R1.^2;   %��ǿ��x����
h=streamline(X,Y,Ex,Ey,x0,y0);         %�����ϲ�����
set(h,'LineWidth',2,'Color','r')       %�Ӵ����߲�ȡ��ɫ

if lambda>0                            %�����ͬ�ֵ��
    dth=dth*abs(1/lambda);             %�ڶ�����ɵ���ʼ�ǺͲ���
    th=dth:dth:180-dth;                %�Ƕ�����
    th=th*pi/180;                      %��Ϊ����
    x0=r0*cos(th)+1;                   %��������
    y0=r0*sin(th);                     %���������
    c=atan((x0+1)./y0)+lambda*atan((x0-1)./y0);%����ȸ��߳���
    contour(X,Y,C,c,'b','LineWidth',2) %�������ֵ��(�糡��)
    contour(X,-Y,C,c,'b','LineWidth',2)%�������ֵ��(�糡��)
    h=streamline(X,Y,Ex,Ey,x0,y0);     %�����ϲ�����
    set(h,'LineWidth',2,'Color','r')   %�Ӵ����߲�ȡ��ɫ
    h=streamline(X,-Y,Ex,-Ey,x0,-y0);  %�����²�����
    set(h,'LineWidth',2,'Color','r')   %�Ӵ����߲�ȡ��ɫ
end                                    %��������
