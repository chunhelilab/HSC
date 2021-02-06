%gradient of parameter a
function gr=gradient_a(xsave,ga_p,S,a,Mat,h,N,flag)
gr=zeros(N,1);
n=4;
k=1;
gr=ga_p';
if flag==1
for i=1:N
    for j=1:N
        if Mat(j,i)==1
            gr(i)=gr(i)+h*grad_r(xsave(j),a(1),S(j,i),n,ga_p(j),1,1);
        end
        if Mat(j,i)==-1
            gr(i)=gr(i)+h*grad_r(xsave(j),a(2),S(j,i),n,ga_p(j),1,2);
        end
    end
    gr(i)=gr(i)-k*h*ga_p(i);
end
end

if flag==2
    for i=1:N
    for j=1:N
        if Mat(j,i)==1
            gr(i)=gr(i)+h*grad_r(xsave(j),a(1),S(j,i),n,ga_p(j),2,1);
        end
        if Mat(j,i)==-1
            gr(i)=gr(i)+h*grad_r(xsave(j),a(2),S(j,i),n,ga_p(j),2,2);
        end
    end
    gr(i)=gr(i)-k*h*ga_p(i);
    end
end
end