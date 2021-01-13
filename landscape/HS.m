function y=HS(x,s,n,a,b,lambda)
y=lambda*a.*x.^n./(s^n+x.^n)+(1-lambda)*b.*s^n./(s^n+x.^n);
end