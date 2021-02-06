clc;
clear;
N=2;
NN=300;
T=1000;
h=0.01;
nstep=T/h;
Mat=[1,-1;-1,1];
ll=zeros(N);
S=[0.3,0.4;0.6,0.7];
a=0.8;
b=1.5;
YY=[];
Y=[];

yi=[1,0.1];
M=1;
y=yi';
ff=zeros(N,1);
kk=0;
Y=[];
for j=1:nstep
        M=1;
          ff=force(y,M,Mat,a,b,S,N);
          if norm(ff)<0.00001
              break
          end
        for i=1:N
         ynew(i)=y(i)+h*ff(i);
         y(i)=ynew(i);
         Y(j,i)=y(i);
        end                 
end
plot(Y)










