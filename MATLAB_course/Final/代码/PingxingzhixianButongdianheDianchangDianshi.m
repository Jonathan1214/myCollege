%直线电荷对的电场线和等势线(等高线法和流线法)
clear,lambda=input('请输入电荷比:');    %键盘输入电荷比
xm=2.5;x=linspace(-xm,xm);             %x坐标范围和横坐标向量
ym=2;y=linspace(0,ym);                 %y坐标范围和纵坐标向量
y(1)=eps;  %零改为小值
[X,Y]=meshgrid(x,y);                   %设置坐标网点
R1=sqrt((X+1).^2+Y.^2);                %第一个(正)电荷到场点的距离
R2=sqrt((X-1).^2+Y.^2);                %第二个电荷到场点的距离
U=2.*(log(1./R1)+lambda.*log(1./R2));	   %计算电势
u=-3:0.5:3;                            %电势向量
C=contour(X,Y,U,u,'LineWidth',2);clabel(C,'FontSize',10); %画上面等势线并取坐标,标记等势线的值
grid on,axis equal,hold on
contour(X,-Y,U,u,'LineWidth',2)	       %画下面等势线
plot([-xm;xm],[0;0],[0;0],[-ym;ym],'LineWidth',2)%画水平线和竖直线

C=atan((X+1)./Y)+lambda*atan((X-1)./Y);%计算电场线常数
r0=0.1;                                %电场线起点半径
dth=20;                                %第一个电荷的起始角和间隔
th=dth:dth:180-dth;                    %角度向量
th=th*pi/180;                          %化为弧度
x0=r0*cos(th)-1;                       %起点横坐标
y0=r0*sin(th);                         %起点纵坐标
c=atan((x0+1)./y0)+lambda*atan((x0-1)./y0);%计算等高线常数
contour(X,Y,C,c,'b','LineWidth',2)     %画上面等值线(电场线)
contour(X,-Y,C,c,'b','LineWidth',2)    %画下面等值线(电场线)
title('直线电荷的电场线和等势线','FontSize',12)%显示标题
xlabel('\itx/a','FontSize',12),ylabel('\ity/a','FontSize',12)
txt=['电势单位:\itk\lambda\rm_1,电荷密度比:',num2str(lambda)];%电势文本
text(-xm,ym-0.5,txt,'FontSize',12)     %标记电势文本

Ey=Y.*(R2.^2+lambda*R1.^2);            %场强的y分量
Ex=(X+1).*R2.^2+lambda*(X-1).*R1.^2;   %场强的x分量
h=streamline(X,Y,Ex,Ey,x0,y0);         %画左上部流线
set(h,'LineWidth',2,'Color','r')       %加粗曲线并取红色

if lambda>0                            %如果是同种电荷
    dth=dth*abs(1/lambda);             %第二个电荷的起始角和步长
    th=dth:dth:180-dth;                %角度向量
    th=th*pi/180;                      %化为弧度
    x0=r0*cos(th)+1;                   %起点横坐标
    y0=r0*sin(th);                     %起点纵坐标
    c=atan((x0+1)./y0)+lambda*atan((x0-1)./y0);%计算等高线常数
    contour(X,Y,C,c,'b','LineWidth',2) %画上面等值线(电场线)
    contour(X,-Y,C,c,'b','LineWidth',2)%画下面等值线(电场线)
    h=streamline(X,Y,Ex,Ey,x0,y0);     %画右上部流线
    set(h,'LineWidth',2,'Color','r')   %加粗曲线并取红色
    h=streamline(X,-Y,Ex,-Ey,x0,-y0);  %画右下部流线
    set(h,'LineWidth',2,'Color','r')   %加粗曲线并取红色
end                                    %结束条件
