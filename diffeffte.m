function [DE1,DE3]=diffeffte(eta1,R,eta3,T)
len=length(eta1);
% icount=-([1:len]-(len+1)/2);
DE1=zeros(len,1);
DE3=zeros(len,2);
DE1=abs(real(eta1/eta1((len+1)/2)).*R.*conj(R));
DE3=abs(real(eta3/eta1((len+1)/2)).*T.*conj(T));

