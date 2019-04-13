function [r,t,DE1,DE3]=reflectionte(eta1,R,eta3,T)
[DE1,DE3]=diffeffte(eta1,R,eta3,T);
r=0;
for icount=1:length(DE1)
    r=r+DE1(icount);
end
t=0;
for icount=1:length(DE3)
    t=t+DE3(icount);
end