function d=statedist(SS,SSexp)
%relative distance
kkkk=size(SS,1);
mp=zeros(1,kkkk);
bc=zeros(1,kkkk);
mac=zeros(1,kkkk);
for i=1:kkkk
     mp(i)=norm(SS(i,:)-SSexp(1,:));
     bc(i)=norm(SS(i,:)-SSexp(2,:));
     mac(i)= norm(SS(i,:)-SSexp(3,:));
end
d=((min(mp)^2+min(bc)^2+min(mac)^2)/(sum(sum(SSexp.^2))))^0.5;
end