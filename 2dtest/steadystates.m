function SS=steadystates(NN,a,S,Mat,M,h,N,nstep)
YY=zeros(NN,N);
for ii=1:NN
yi=rand(1,N);
y=yi';
ff=zeros(N,1);
for j=1:nstep
ff=force(y,M,Mat,a(1),a(2),S,N);
if norm(ff)<0.001
     break
end
for i=1:N
y(i)=y(i)+h*ff(i);
end           
end
YY(ii,:)=y';
end
%计算稳态个数
SS=YY(1,:);
siz2=size(YY,1);
s(1)=1;%%不同稳态的占比
for i=2:siz2
    siz=size(SS,1);
    d=zeros(siz,1);
    for j=1:siz
        d(j)= (sum((YY(i,:)-SS(j,:)).^2))^(0.5);
    end
    if d>0.05
            SS=[SS;YY(i,:)];
            s=[s;1];
    else
            sn=s(d<1);
            s(d<1)=sn+1;
    end
end

end