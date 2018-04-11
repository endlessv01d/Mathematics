%比较不同时间步对数值解稳定性的影响
clear;clc;
x=0:0.05:1;%自变量步长为0.05
u_1=0.0012/0.05^2;%时间步为0.0012
u_2=0.0013/0.05^2;%时间步为0.0013
%预留数据空间
U_1=zeros(51,21);U_2=zeros(51,21);k=1:21;
%初始的帽形函数的值
U_1(1,k)=-abs(2*x(k) - 1) + 1;
U_2(1,k)=-abs(2*x(k) - 1) + 1;
for j=1:50
    for i=1:19
        U_1(j+1,i+1)=U_1(j,i+1)+u_1.*(U_1(j,i)+U_1(j,i+2)-2.*U_1(j,i+1));%按时间步0.0012迭代
        U_2(j+1,i+1)=U_2(j,i+1)+u_2.*(U_2(j,i)+U_2(j,i+2)-2.*U_2(j,i+1));%按时间步0.0013迭代
    end
end
x_plot=0:0.01:1;%用于画图的横坐标
%求原函数值用于画图，无穷级数截断到100项
y1_0=0;y1_1=0;y1_25=0;y1_50=0;y2_0=0;y2_1=0;y2_25=0;y2_50=0;
for n=1:100
    %时间步为0.0012
    y1_0=y1_0+8./(n.*pi).^2.*sin(n.*pi./2).*sin(n.*pi*x_plot);
    y1_1=y1_1+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0012).*sin(n.*pi*x_plot);
    y1_25=y1_25+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0012.*25).*sin(n.*pi*x_plot);
    y1_50=y1_50+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0012.*50).*sin(n.*pi*x_plot);
    %时间步为0.0013
    y2_0=y2_0+8./(n.*pi).^2.*sin(n.*pi./2).*sin(n.*pi*x_plot);
    y2_1=y2_1+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0013).*sin(n.*pi*x_plot);
    y2_25=y2_25+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0013.*25).*sin(n.*pi*x_plot);
    y2_50=y2_50+8./(n.*pi).^2.*sin(n.*pi./2).*exp(-n^2.*pi^2.*0.0013.*50).*sin(n.*pi*x_plot);
end
%t=0时
subplot(421);plot(x_plot,y1_0,x,U_2(1,k));
subplot(422);plot(x_plot,y2_0,x,U_2(1,k));
%1个时间步后
subplot(423);plot(x_plot,y1_1,x,U_1(2,k));
subplot(424);plot(x_plot,y2_1,x,U_2(2,k));
%25个时间步后
subplot(425);plot(x_plot,y1_25,x,U_1(26,k));
subplot(426);plot(x_plot,y2_25,x,U_2(26,k));
%50个时间步后
subplot(427);plot(x_plot,y1_50,x,U_1(51,k));
subplot(428);plot(x_plot,y2_50,x,U_2(51,k));
