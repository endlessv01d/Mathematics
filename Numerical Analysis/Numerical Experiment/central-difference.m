clear;clc;
x=1:0.01:3;%步进为0.01的自变量
y2=2.*exp(x).*cos(x);%f(x)的二阶导数
i=1:201;%计数变量
for m=1:6
    h=1./2.^m;%分别计算m从1到6的步长
    a=double(vpa(exp(i./100+0.99-h).*sin(i./100+0.99-h),5));
    b=double(vpa(exp(i./100+0.99+h).*sin(i./100+0.99+h),5));
    c=double(vpa(exp(i./100+0.99).*sin(i./100+0.99),5));
    approx(i,m)=(a+b-2.*c)./h.^2;
    %中心差商公式，其中vpa(x,n)表示保留n位有效数字的x，输出为符号型，需要用double()转换
end
plot(x,approx(i,1),'y',x,approx(i,2),'c',x,approx(i,3),'g',x,approx(i,4),'b',x,approx(i,5),'r',x,approx(i,6),'m',x,y2,'k');
