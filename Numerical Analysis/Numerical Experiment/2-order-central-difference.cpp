#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;

double rd5(double);
double f(double);
double f2approx(double, int);

int main()
{
    int m,n;
	double x, f2;
	for (n = 0; n <= 10; n++)
	{
		x = 1 + 0.2*n;
		f2 = 2 * exp(x)*cos(x);
		cout << "x = " << fixed << setprecision(1) << x << "\t" << setprecision(6)
			<< "f2prec = " << f2 << endl;
		for (m = 1; m <= 6; m++)
		{
			cout << "m = " << m
				<< "\tf2appr = " << f2approx(x, m)
				<< "\tremainder = " << f2 - f2approx(x, m) << endl;
		}

	}
	cin.get();
	return 0;
}

double rd5(double x)//计算绝对值小于10的数保留5位有效数字的值
{
	double r,s,t;
	int y;
	s=abs(x);
	int z = floor(log10(s))-4;
	y = s / pow(10,z);
	t = s / pow(10,z) - y;
	if(t<0.5)
    {
        r=y*pow(10,z);
    }
	else
    {
        r=(y+1)*pow(10,z);
    }
    if(s==x)
    {
        return r;
    }
    else
    {
        return -r;
    }
}

double f(double x)//计算f(x)的值
{
	return rd5(exp(x)*sin(x));
}

double f2approx(double x, int m)//计算f(x)的估计值
{
	return (f(x + 1 / pow(2, m)) + f(x - 1 / pow(2, m)) - 2 * f(x)) / pow(2, -2 * m);
}
