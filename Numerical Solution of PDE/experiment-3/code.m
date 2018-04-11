%2-11
clear;clc;
t=0:0.005:1;x=0:0.1:1;
%图1
U1=zeros(201,11);U1(1,:)=1-x(:).^2;
a1=1/4;b1=1+1/2;
d1=zeros(1,9);e1=zeros(1,9);f1=zeros(1,9);
for j=1:200
    for i=1:9
        d1(i)=U1(j,i+1)+0.25*(U1(j,i)+U1(j,i+2)-2*U1(j,i+1));
    end
    for i=1:9
        if i==1
            e1(i)=a1/(b1-a1);f1(i)=d1(i)/(b1-a1);
        else
            e1(i)=a1/(b1-a1*e1(i-1));f1(i)=(d1(i)+a1*f1(i-1))/(b1-a1*e1(i-1));
        end
    end
    U1(j+1,11)=f1(9)/(1-e1(9));
    for i=10:-1:1
        if i~=1
            U1(j+1,i)=e1(i-1)*U1(j+1,i+1)+f1(i-1);
        else
            U1(j+1,i)=U1(j+1,i+1);
        end
    end
end
%图2
U2=zeros(201,11);U2(1,:)=1-x(:).^2;
a2=1/4;b2=1+1/2;
d2=zeros(1,11);e2=zeros(1,11);f2=zeros(1,11);
for j=1:200
    for i=1:11
        if i==1
            d2(i)=U2(j,i)+0.25*(U2(j,i+1)+U2(j,i+1)-2*U2(j,i));
        elseif i==11
            d2(i)=U2(j,i)+0.25*(U2(j,i-1)+U2(j,i-1)-2*U2(j,i));
        else
            d2(i)=U2(j,i)+0.25*(U2(j,i-1)+U2(j,i+1)-2*U2(j,i));
        end
    end
    for i=1:11
        if i==1
            e2(i)=a2/(b2-a2*3);f2(i)=(d2(i)+a2*(-2)*d2(i))/(b2-a2*3);
        else
            e2(i)=a2/(b2-a2*e2(i-1));f2(i)=(d2(i)+a2*f2(i-1))/(b2-a2*e2(i-1));
        end
    end
    U2(j+1,11)=(e2(11)*f2(10)+f2(11))/(1-e2(10)*e2(11));
    for i=10:-1:1
        U2(j+1,i)=e2(i)*U2(j+1,i+1)+f2(i);
    end
end
%图3
U3=zeros(201,12);
for j=2:11
    U3(1,j)=1-(3*(j-1)^2-3*(j-1)+1)/300;
end
U3(1,1)=U3(1,2);U3(1,12)=U3(1,11);
a3=1/4;b3=1+1/2;
d3=zeros(1,10);e3=zeros(1,10);f3=zeros(1,10);
for j=1:200
    for i=1:10
        d3(i)=U3(j,i+1)+0.25*(U3(j,i)+U3(j,i+2)-2*U3(j,i+1));
    end
    for i=1:10
        if i==1
            e3(i)=a3/(b3-a3);f3(i)=d3(i)/(b3-a3);
        else
            e3(i)=a3/(b3-a3*e3(i-1));f3(i)=(d3(i)+a3*f3(i-1))/(b3-a3*e3(i-1));
        end
    end
    U3(j+1,12)=f3(10)/(1-e3(10));
    for i=11:-1:1
        if i~=1
            U3(j+1,i)=e3(i-1)*U3(j+1,i+1)+f3(i-1);
        else
            U3(j+1,i)=U3(j+1,i+1);
        end
    end
end
%原函数
U0=zeros(201,11);
for i=1:201
    for j=1:11
        U0(i,j)=uu(x(j),t(i));
    end
end
%原函数真实值
U00=zeros(201,10);
for i=1:201
    for j=1:10
        U00(i,j)=uuu(i,j);
    end
end
%图1
ee1=abs(U1-U0);
ee11=zeros(1,11);
for i=1:201
    ee11(i)=max((ee1(i,:)));
end
%图2
ee2=abs(U2-U0);
ee21=zeros(1,11);
for i=1:201
    ee21(i)=max((ee2(i,:)));
end
%图3
U33=U3(:,2:1:11);
ee3=abs(U33-U00);
ee31=zeros(1,10);
for i=1:201
    ee31(i)=max((ee3(i,:)));
end
%画图
plot(t,log10(ee11),t,log10(ee21),t,log10(ee31));

function y= uu(x,t)
%原函数
y=2/3;
for i=1:1000
    y=y-2*(2/(i*pi)^2*cos(i*pi))*exp(-(i*pi)^2*t)*cos(i*pi*x);
end

function y =uuu(i,j)
%原函数积分
y=2/3;
for n=1:100
    y=y+10*(-4*cos(n*pi)/(n*pi)^3)*exp(-(n*pi)^2*(i-1)*0.005)*(sin(n*pi*(j)*0.1)-sin(n*pi*(j-1)*0.1));
end
