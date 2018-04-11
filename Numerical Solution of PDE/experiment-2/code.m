%Crank-Nicolson scheme
clear;clc;
%构造一个三位矩阵，用于存放U值
U=zeros(2,11,21);U(:,1,11)=1;
%预先计算好a,b,c
a=[0.5,1];b=[2,3];
%为d,e,f分配空间
d=zeros(2,19);e=zeros(2,19);f=zeros(2,19);
%分别计算u=1和u=2的情形
for u=1:2
    %10个时间步
    for n=2:11
        %计算特定时间步的d
        for j=1:19
            d(u,j)=U(u,n-1,j+1)+0.5*u*(U(u,n-1,j)+U(u,n-1,j+2)-2*U(u,n-1,j+1));
        end
        %计算特定时间步的e,f
        for j=1:19
            if j==1
                e(u,j)=a(u)/b(u);f(u,j)=d(u,j)/b(u);
            else
                e(u,j)=a(u)/(b(u)-a(u)*e(u,j-1));
                f(u,j)=(d(u,j)+a(u)*f(u,j-1))/(b(u)-a(u)*e(u,j-1));
            end
        end
        %计算最终的U
        for j=20:-1:2
            U(u,n,j)=e(u,j-1)*U(u,n,j+1)+f(u,j-1);
        end
    end
end
%将三维矩阵划分为2个二维矩阵，用于画图（plot函数不可使用三维矩阵）
U1=reshape(U(1,:,:),11,21);U2=reshape(U(2,:,:),11,21);
%构造很横坐标，用于画图
x=0:0.05:1;
subplot(421);plot(x,U1(1,:));%图1
subplot(422);plot(x,U2(1,:));%图2
subplot(423);plot(x,U1(2,:));%图3
subplot(424);plot(x,U2(2,:));%图4
subplot(425);plot(x,U1(3,:));%图5
subplot(426);plot(x,U2(3,:));%图6
subplot(427);plot(x,U1(11,:))%图7
subplot(428);plot(x,U2(11,:))%图8
