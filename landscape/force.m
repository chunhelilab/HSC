%
function f = force(x,M,Mat,a,b,S)
N=23;
% M=10;
% M=100;
% f = zeros(N,M);
G = zeros(N,M);
K = ones(N,M);

nn = 5;
% S = 400;
% g=100*ones(N,M);
% k=1*ones(N,M);
% L=5;
% L_=0.2;

% Mat=load ('MatrixT2.txt');

for i=1:N
%     K(i,:)=k(i);

for j=1:N

     if Mat(j,i)==1
%        if j==i
%          G(i,:)=G(i,:).*HS(x(j,:),S,nn,ll);
%        else
%          G(i,:)=G(i,:).*HS(x(j,:),S,nn,lplus);
         G(i,:)=G(i,:)+HS(x(j,:),S(j,i),nn,a,b,1);
%        end
     end
     
     if Mat(j,i)==-1
%        if j==13||j==14||j==15||j==16  
%          K(i,:)=K(i,:).*HS(x(j,:),S,nn,1/L_)*L_;
%        else
%          G(i,:)=G(i,:).*HS(x(j,:),S,nn,ll(j,i));
%        end
        G(i,:)=G(i,:)+HS(x(j,:),S(j,i),nn,a,b,0);
     end
end     

f(i,:)=G(i,:) - K(i,:).*x(i,:);
end

% 
