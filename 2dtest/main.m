%%%gradient descent in a simulated 2-gene system
clc;clear;
%% initializing
Mat=[1,-1;-1,1]; %regulatory network
N=2;             %number of genes
M=1;
h=0.01;          %step in Euler method
NN=1000;         
nstep=10000;     

pflag=0;
l=0.005;         %learning rate
%
a=[2,2.5];
S=[0.3,0.4;0.6,0.8];
%three stable states x1,x3,x3 of a simulated system and steady states matrix SSexp
% a=[1,1]; 
% S=[0.5,0.5;0.5,0.5]; 
x1=[9.793176056415679e-04;1.999012068550250];
x2=[1.999012068550250;9.793176056415679e-04];
x3=[1;1];
SSexp=[9.793176056415679e-04,1.999012068550250;1.999012068550250,9.793176056415679e-04;1,1];

% x1=[0.00121600801054795,2.09835566126525];
% x2=[2.099530874910735,0.001149431884705];
% x3=[0.915277357015253,0.912461734357177];
% SSexp=[0.00121600801054795,2.09835566126525;2.099530874910735,0.001149431884705;0.915277357015253,0.912461734357177];
%% gradient descent
num=1;
step=100;          %step of gradient descent
plotmatrix=zeros(step,3); 
asave=zeros(step,2); 
ssave=zeros(step,2,2);
while num<=step             %%si is N*1 matrix/grad_ai is N*2 matrix/grad_Si is N*N*N matrix
SS=steadystates(NN,a,S,Mat,M,h,N,nstep);   
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
    l=0.8*l;
end
a;
S;
asave(num,:)=a;
ssave(num,:,:)=S;

[s1,grad_a1,grad_S1]=sslossd(x1,a,S,Mat,M,h,N,nstep);   
[s2,grad_a2,grad_S2]=sslossd(x2,a,S,Mat,M,h,N,nstep);
[s3,grad_a3,grad_S3]=sslossd(x3,a,S,Mat,M,h,N,nstep);
state=[s1,s2,s3]';
grad_S=zeros(N,1);
grad_a=2*(grad_a1.*(s1-x1)+grad_a2.*(s2-x2)+grad_a3.*(s3-x3));
SM=sum(abs(Mat));
SM(SM==0)=100;
grad_a=grad_a./SM';
for ind=1:N
grad_S(ind)=2*((s1(ind)-x1(ind))*grad_S1(ind)+(s3(ind)-x3(ind))*grad_S3(ind)+(s2(ind)-x2(ind))*grad_S2(ind));
end
da=sum(grad_a,1);
dS=sum(grad_S);

a=a-l*da;
S=S-l*dS;

%calculating loss
loss=(norm(s1-x1))^2+(norm(s2-x2))^2+(norm(s3-x3))^2;
plotmatrix(num,1)=loss;
plotmatrix(num,2)=size(SS,1);
plotmatrix(num,3)=statedist_2dimension(state,SSexp);


disp("round "+num2str(num)+" of the optimization             "+" the loss is "+num2str(loss))
disp("----------------------------------------------------------------------------")
disp("the dist is    "+num2str(plotmatrix(num,3)))
num=num+1;
end


%plot the loss 
yyaxis left
plot(1:step,plotmatrix(:,3),'k')
ylabel("loss");
yyaxis right
plot(1:step,asave);
ylabel("parameter a and b");
xlabel("time");
legend("loss","a","b");
