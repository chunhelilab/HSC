%%gradient descent in a simulated 2-gene system
%our aim is to optimize the parameter a,b,S so that the steady states are close to the experiment date
clc;clear;
%initializing parameters
Mat=[1,-1;-1,1]; %regulatory network matrix
N=2;             %number of genes
%parameters in Euler method
h=0.05;         
NN=500;          
nstep=10000;     
pflag=0;
l=0.01;          %learning rate
a=[2,2.5];       %initial parameter a,b,S
S=[0.3,0.4;0.5,0.6];

%three stable states x1,x3,x3(experiment data) of the simulated system (a=1,b=1,S_{ij}=0.5)
%and steady states matrix SSexp
%This is computed with steadystates.m
x1=[9.793176056415679e-04;1.999012068550250];
x2=[1.999012068550250;9.793176056415679e-04];
x3=[1;1];
SSexp=[9.793176056415679e-04,1.999012068550250;1.999012068550250,9.793176056415679e-04;1,1];

%% Gradient Descent
num=1;
step=1000;          %steps of gradient descent
plotmatrix=zeros(step,2);  
asave=zeros(step,2); 
ssave=zeros(step,2,2);
while num<=step            
SS=steadystates(NN,a,S,Mat,h,N,nstep);   
disp("The number of steady states:"+num2str(size(SS,1)))
%% Decrease the lrate and rerun if there's a phase change
if size(SS,1)<3
    if pflag > 10
        break
    end
    disp("the number of steady states is less than 3, decreasing the learning rate and rerun");
    pflag=pflag+1;
    num=num-1;
    a=asave(num,:);
    S=ssave(num,:,:);
    S=reshape(S,N,N);
    l=0.8*l;
end
asave(num,:)=a;
ssave(num,:,:)=S;

%si is the computed steady state
%grad_ai is N*2 matrix/grad_Si is N*N*N matrix 
[s1,grad_a1,grad_S1]=sslossd(x1,a,S,Mat,h,N,nstep);   
[s2,grad_a2,grad_S2]=sslossd(x2,a,S,Mat,h,N,nstep);
[s3,grad_a3,grad_S3]=sslossd(x3,a,S,Mat,h,N,nstep);
state=[s1,s2,s3]';
grad_S=zeros(N,N,N);
grad_a=2*(grad_a1.*(s1-x1)+grad_a2.*(s2-x2)+grad_a3.*(s3-x3));
for ind=1:N
grad_S(ind,:,:)=2*((s1(ind)-x1(ind))*grad_S1(ind,:,:)+(s3(ind)-x3(ind))*grad_S3(ind,:,:)+(s2(ind)-x2(ind))*grad_S2(ind,:,:));
end
da=sum(grad_a,1);
dS=sum(grad_S,1);
dS=reshape(dS,[N,N]);

%%Updating the parameter
a=a-l*da;
S=S-l*dS;

%%Calculating loss
loss=(norm(s1-x1))^2+(norm(s2-x2))^2+(norm(s3-x3))^2;
plotmatrix(num,1)=loss;
plotmatrix(num,2)=size(SS,1);
disp("round "+num2str(num)+" of the optimization             "+" the loss is "+num2str(loss))
disp("----------------------------------------------------------------------------")
num=num+1;
end

%%Plot
yyaxis left
plot(1:num-1,plotmatrix(:,1),'k')
ylabel("loss");
yyaxis right
plot(1:num-1,asave);
ylabel("parameter a and b");
xlabel("time");
legend("loss","a","b");
