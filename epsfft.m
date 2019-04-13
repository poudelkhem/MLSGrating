function [epsh,ah]=epsfft(rindex,nmode)
% epsh=epsfft(refractive_index,rcwa_mode_number)
% length(refractive_index) should be greater than 2^nextpow2(4*nmode+2)
% epsh will be a vector containing the Fourier coefficients of the 
% refractive index distribution in a period
% one should make sure that length(rindex)=nfft
lindex=length(rindex);
rindex=rindex.^2;
arindex=1./rindex;
nfftmode=4*nmode+2;
nfft=2^nextpow2(nfftmode);
if lindex~=nfft
    disp(['Warning: set the index profile resolution to '...
        num2str(nfft) ' will be better.']);
    % if lindex~=nfft, MATLAB will add zero to rindex, so the result will
    % deviate from what it's supposed to be.
end
eps=fft(rindex,nfft)/lindex;
epsh=zeros(4*nmode+1,1);
epsh(2*nmode+1:end)=eps(1:2*nmode+1);
epsh(1:2*nmode)=eps(nfft-2*nmode+1:nfft);
a=fft(arindex,nfft)/lindex;
ah=zeros(4*nmode+1,1);
ah(2*nmode+1:end)=a(1:2*nmode+1);
ah(1:2*nmode)=a(nfft-2*nmode+1:nfft);
