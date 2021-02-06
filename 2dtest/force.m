%this function is used in Euler method
function f = force(x,Mat,a,b,S,N)
G = zeros(N,1);
K = ones(N,1);
nn = 5;
for i=1:N
for j=1:N
     if Mat(j,i)==1
        G(i,:)=G(i,:)+HS(x(j,:),S(j,i),nn,a,b,1);
     end     
     if Mat(j,i)==-1
        G(i,:)=G(i,:)+HS(x(j,:),S(j,i),nn,a,b,0);
     end
end     
f(i,:)=G(i,:) - K(i,:).*x(i,:);
end
