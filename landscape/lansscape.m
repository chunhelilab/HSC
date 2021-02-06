%constructing landscape/moment equations
NN=200;
N=23; %number of genes
%model parameters 
a=[0.337511189025118,1.71547257494506];
S=[0,0.480600205334567,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0.476649368187831,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0.554371833543858,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0.214050066866581,1.01150782043768,0,0,0.252641011423531,1.69975080864157,0,0,0.350423829802572,0,0,1.52040161693672,0,0.814096045953305,1.50624159053630,1.18054139453856,0.479822417546709,0,1.54849970683895,0;0,0,0,0,1.26392277161559,0,0,1.18428791741280,0,0,0,0,0,0,1.13406744919528,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0.419584238527765,0,0,0,1.98096558142731,0,0,0,0,0,0,0,0,0,0,0,0.244053016954201,0,0,0;0,0,1.06514204169624,0.572841820442919,1.58348750975792,1.65039892153491,0.107160582410745,0.915435300555898,0.0249851643835273,0,0.0500111603035696,0,1.72825463447869,0.615469774694976,1.99729547393664,0,0,0,0,0.664343225526201,0,0.933465752624602,0;0,0,0,0,0,0,0,0,0,0.0487449014501367,0,0,0,0,0,0,0,0,0,0,0,1.02705249108881,0;0,0,0,1.85043137962998,0,0,0,0.163444200493577,0,0,0.940461834844422,1.14193139093449,0,0.670631183262661,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0.674895133098312,0,0,0,0,0.331029189759052,0,0.218858928925101,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0.313802289053661,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.353185627844549,0,0,1.11008486894588,1.14639185987039,0,0.410643931420508,0;0,0,0,0,0,0,0,0,0,0,0,0,0,1.60648141222713,0,0,1.53797314690595,0,0,1.77935795133810,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.920514406593979,0,0,0;0,0,1.04701348867071,0,0,0,0,1.84381352680896,0,1.86896670442684,1.35667450118034,0,0,1.44888258274463,0,0,0,1.41835258838623,0,0.259706270688201,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0.841941255633873,0,0,0,0,0,0,0,0,0,1.72430244852520,0,0,0,0,0,1.08431396247711,0,0.433907714317311,0;0,0,0,0,0,0,0,0,0,0,0,0,0,1.58652122407020,1.99977496395109,0,0.601122884759696,0,0,1.17832240893235,0,0.945563028894612,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.118281477607919;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0274443228968884;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.952579418671455,0,0,0];
load('matrix.mat'); %regulatory network
load('ss4.mat');    %steady states
load('vars.mat');   %diffusion matrix
Mat=matrix;
M=1;
T=5000;
h=0.05;
nstep=T/h;
XX=zeros(NN,N);
SX=zeros(N,N,NN);
AX=zeros(N,N,NN);
fX=zeros(N,N,NN);
for i=1:NN
x=NN*rand(N,1);
sigma=NN*rand(N);
ff1=zeros(N,1);
ff2=zeros(N);
X=zeros(nstep,N);
Sigma=zeros(N,N,nstep);
%stable state
for j = 1:nstep
ff1=force(x,M,Mat,a(1),a(2),S);
   for ii=1:N
   x(ii)=x(ii)+h*ff1(ii);
   X(j,ii)=x(ii);
   end
if norm(ff1)<0.001
    break
end
end
for jj=1:4
    dis(jj)=norm(ss4(jj,:)-x');
end
[m,mu]=min(dis);
va=vars(:,4);
for j=1:nstep 
ff2=fforce1(x,sigma,Mat,a(1),a(2),S,va);
for ii=1:N
    for jj=1:N
        sigma(ii,jj)=sigma(ii,jj)+h*ff2(ii,jj);
        Sigma(ii,jj,j)=sigma(ii,jj);
        fX(ii,jj,j)=ff2(ii,jj);
    end
end
if norm(ff2,'fro')<0.001
    break
end
end
XX(i,:)=x';
SX(:,:,i)=sigma;
end
SS=[];
SS=XX(1,:);
siz2=size(XX);
s=[];
sss=1;
s(1)=sss;
un=1;
for i=2:siz2(1)
    siz=size(SS);
    d=[];
    for j=1:siz(1)
        d(j)= (sum((XX(i,:)-SS(j,:)).^2))^(0.5);
    end
    if d>0.1
            SS=[SS;XX(i,:)];
            s=[s;1];
            un=[un,i];
    else
            sn=s(d<1);
            s(d<1)=sn+1;
    end
end
SSnew=nor(SS);
%PLOT 
%project on Cd19 and mac1 
[z1,z2]=meshgrid(0:0.01:1.2);
z3=s(1)/100.*gau(z1,SSnew(1,6),SX(6,6,un(1))).*gau(z2,SSnew(1,18),SX(18,18,un(1)))+s(2)/100.*gau(z1,SSnew(2,6),SX(6,6,un(2))).*gau(z2,SSnew(2,18),SX(18,18,un(2)))+s(3)/100.*gau(z1,SSnew(3,6),SX(6,6,un(3))).*gau(z2,SSnew(3,18),SX(18,18,un(3)))+s(4)/100.*gau(z1,SSnew(4,6),SX(6,6,un(4))).*gau(z2,SSnew(4,18),SX(18,18,un(4)));
z3=min(-10*log(z3),100);
surf(z1,z2,z3)
shading interp
xlabel("mac1")
ylabel("Cd19")
zlabel("U")