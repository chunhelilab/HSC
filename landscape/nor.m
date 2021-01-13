function SS1= nor(SS)
% N=23;
kkkk=size(SS);
ma=zeros(1,kkkk(2));
SS1=zeros(kkkk(1),kkkk(2));
for nnnn=1:kkkk(2)
    ma(nnnn)=max(SS(:,nnnn));
    for jjj=1:kkkk(1)
    SS1(jjj,nnnn)=SS(jjj,nnnn)./ma(nnnn);
    end
end

