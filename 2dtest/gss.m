function g=gs(n,s,x,ds,ind)
if ind==1
    g=n*s^n*x^(n-1)*ds-n*x^n*s^(n-1);
    g=g/(s^n+x^n)^2;
end
if ind==2
    g=-n*s^n*x^(n-1)*ds+n*x^n*s^(n-1);
    g=g/(s^n+x^n)^2;
end
end