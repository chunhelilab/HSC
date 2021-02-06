%this function is used to calculate the steady state ss and gradient grad_a, grad_S from initial state x0
function [ss,grad_a,grad_S]=sslossd(x0,a,S,Mat,h,N,nstep)
ga=zeros(2,N,nstep);
gS=zeros(N,N,N,nstep);
xsave=zeros(N,nstep);
xsave(:,1)=x0;
ga(:,:,1)=0;
gS(:,:,:,1)=0;
for j=1:nstep-1
ff=force(xsave(:,j),Mat,a(1),a(2),S,N);
if norm(ff)<0.001
     break
end
for i=1:N
xsave(i,j+1)=xsave(i,j)+h*ff(i);
end
ga(1,:,j+1)=gradient_a(xsave(:,j),ga(1,:,j),S,a,Mat,h,N,1);
ga(2,:,j+1)=gradient_a(xsave(:,j),ga(2,:,j),S,a,Mat,h,N,2);
for i=1:N
    for ii=1:N
        for jj=1:N
            gS(i,ii,jj,j+1)=gradient_Sd(i,xsave(:,j),gS(:,ii,jj,j),S,a,Mat,h,N,ii,jj);
        end
    end
end
end
ss=xsave(:,j);
grad_a=ga(:,:,j)';
grad_S=gS(:,:,:,j);
end