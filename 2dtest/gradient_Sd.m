function gs=gradient_Sd(i,x,ds,S,a,Mat,h,N,ii,jj)
gs=ds(i);
k=1;
n=5;
if i==jj
    if Mat(ii,jj)==1
            gs=gs+h*a(1)*gss(n,S(ii,jj),x(ii),ds(i),1);
    elseif Mat(ii,jj)==-1
            gs=gs+h*a(2)*gss(n,S(ii,jj),x(ii),ds(i),2);
    end
end
gs=gs-k*h*ds(i);
end





