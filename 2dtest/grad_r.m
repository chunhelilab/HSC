%gradient
function dd=grad_r(x,a,s,n,da,ge,regu)
if ge==1
    if regu==1
dd=x^n/(s^n+x^n)+a*n*x^(n-1)*s^n*da/(x^n+s^n)^2;
    elseif regu==2
            dd=-a*s^n*n*x^(n-1)*da/(s^n+x^n)^2;
    end
end
if ge==2 
    if regu==1
        dd=a*s^n*n*x^(n-1)*da/(s^n+x^n)^2;
    elseif regu==2
        dd=s^n/(s^n+x^n)-a*n*x^(n-1)*s^n*da/(x^n+s^n)^2;
    end
end
end