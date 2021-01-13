function f=fforce1(x,sigma,Mat,a,b,S,va)
nn=5;
N=23;
D=diag(va);
% D=zeros(N)+0.02;
% D=diag(diag(D));
% D(1,1)=0;
% D(21,21)=0;
A=zeros(N);
k=1;
for i=1:N
for j=1:N
     if Mat(j,i)==1
        A(i,j)=HSS(x(j),S(j,i),nn,a,b,1);     
     end    
     if Mat(j,i)==-1
        A(i,j)=HSS(x(j),S(j,i),nn,a,b,0);
     end
end
A(i,i)=A(i,i)-k;
end

B=sigma*A';
C=A*sigma;
f=B+C+D;
end