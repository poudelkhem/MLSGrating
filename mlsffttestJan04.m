
% *****************   FFT mls*********************
%@ Khem N poudel, Date01/04/2019,MTSU

%************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Defining all the variables and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 close all; clc;clear all; 
figure(1)
p=[1 0 1 0 1 0 1 0];
fp=fft(p);
fp1=fp/max(fp);
stem(abs(fp1));
figure(2)
MLS=[1 1 1 0 0 1 0];
fMLS=fft(MLS);
fMLS2=fMLS/max(fMLS);
stem(abs(fMLS2));