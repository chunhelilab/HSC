function y=HSS(x,s,n,a,b,lambda)
y=(a*lambda*n*x^(n - 1))/(s^n + x^n) + (b*n*s^n*x^(n - 1)*(lambda - 1))/(s^n + x^n)^2 - (a*lambda*n*x^n*x^(n - 1))/(s^n + x^n)^2;
end