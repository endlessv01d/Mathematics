clear;clc;
x=1:0.01:3;%步进为0.01的自变量
x1=0.1:0.01:3.9;%扩大范围的自变量,用于求范围均值
y=exp(x).*sin(x);%f(x)
awgn=awgn(exp(x1).*sin(x1),10);%产生高斯白噪声,SNR=10
plot(x,awgn(91:291),'r',x,y,'k');
y2=2.*exp(x).*cos(x);%f(x)的二阶导数
for i=1:201
    approx0(i)=100.*(awgn(i+80)+awgn(i+100)-2.*awgn(i+90));%对原始噪声直接使用中心差商近似
end
plot(x,approx0,'r',x,y2,'k');
for i=1:341
    filter1(i)=sum(awgn(i:i+40))./41;%第1次处理
end
plot(x,filter1(71:271),'r',x,y,'k');
for i=1:201
    approx1(i)=100.*(filter1(i+60)+filter1(i+80)-2.*filter1(i+70));%第1次处理后使用中心差商近似
end
plot(x,approx1,'r',x,y2,'k');
for i=1:301
    filter2(i)=sum(filter1(i:i+40))./41;%第2次处理
end
for i=1:261
    filter3(i)=sum(filter2(i:i+40))./41;%第3次处理
end
for i=1:221
    filter4(i)=sum(filter3(i:i+40))./41;%第4次处理
end
for i=1:201
    approx2(i)=100.*(filter2(i+40)+filter2(i+60)-2.*filter2(i+50));
    %第2次处理后使用中心差商近似
end
for i=1:201
    approx3(i)=100.*(filter3(i+20)+filter3(i+40)-2.*filter3(i+30));
    %第3次处理后使用中心差商近似
end
for i=1:201
    approx4(i)=100.*(filter4(i)+filter4(i+20)-2.*filter4(i+10));
    %第4次处理后使用中心差商近似
end
plot(x,filter1(71:271),'c',x,filter2(51:251),'r',x,filter3(31:231),'g',x,filter4(11:211),'b',x,y,'k');
%四次处理与原函数对比
plot(x,approx1,'c',x,approx2,'r',x,approx3,'g',x,approx4,'b',x,y2,'k');
%四次中心差商近似与原函数二阶导数对比
