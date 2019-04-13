function rcwatm(mr)
t1=tic;
wavelength=mr.LightSource.Wavelength;
% the wavelength of the light in the air
incidentangle=mr.LightSource.IncidentAngle;
% the angle between the incident light and the normal direction of the
% layers, in degree
period=mr.Period;
% the grating period
nmode=mr.ModeNumber;
% number of Bloch modes, the higher the more accurate
nfft=mr.IndexProfileResolution;
L=mr.LayerNumber;
% number of layers including the incident and outgoing layers as the first
% and last layer
twonmode=2*nmode;
twonmode1=twonmode+1;
twonmode2=twonmode+2;
threenmode2=3*nmode+2;
fournmode=4*nmode;
fournmode1=fournmode+1;
fournmode2=fournmode+2;


thickness=zeros(L,1);
% if the thickness of a layer is zeros, it's either the incident layer or
% the out going layer
for icount=1:L
    thickness(icount)=mr.Layers{icount}.LayerThickness;
end

index=ones(nfft,L);
% refractive index, the default values for all the layers are one
for icount=1:L
    index(:,icount)=mr.Layers{icount}.IndexProfile;
end

eps=zeros(fournmode1,L);
ah=eps;
for icount=1:L
    [eps(:,icount),ah(:,icount)]=epsfft(index(:,icount),nmode);
end

morder=-((1:twonmode1)-nmode-1)';   
% mode order indices
k0=2*pi/wavelength;
% k0 is the wave vector in vacuum
kx=k0*(index(1,1)*sind(incidentangle)-morder*wavelength/period);
% kx contains all the Block modes kx components
kz1=k0*sqrt(index(1,1)^2-(kx/k0).^2);
kz1=1i*conj(1i*kz1);
kzL=k0*sqrt(index(1,L)^2-(kx/k0).^2);
kzL=1i*conj(1i*kzL);
Z1=diag(kz1/k0/index(1,1)^2);
ZL=diag(kzL/k0/index(1,L)^2);

I=eye(twonmode1);
KX=diag(kx/k0);
E=zeros(twonmode1,twonmode1,L);
% the matrix composed of eps(i-j)
W=E;
V=E;
X=E;
A=E;
a=E;
b=E;
q=zeros(twonmode1,L);
for jcount=2:L-1
    for icount=1:twonmode
        E(:,:,jcount)=E(:,:,jcount)...
            +diag(eps(twonmode1-icount,jcount)*ones(twonmode1-icount,1)...
            ,-icount);
        E(:,:,jcount)=E(:,:,jcount)...
            +diag(eps(twonmode1+icount,jcount)*ones(twonmode1-icount,1)...
            ,icount);
        A(:,:,jcount)=A(:,:,jcount)...
            +diag(ah(twonmode1-icount,jcount)*ones(twonmode1-icount,1)...
            ,-icount);
        A(:,:,jcount)=A(:,:,jcount)...
            +diag(ah(twonmode1+icount,jcount)*ones(twonmode1-icount,1)...
            ,icount);
    end
    % off diagnal elements of E
    E(:,:,jcount)=E(:,:,jcount)+eps(twonmode1,jcount)*I;
    % diagnal elements of E
    A(:,:,jcount)=A(:,:,jcount)+ah(twonmode1,jcount)*I;
    EB=A(:,:,jcount)\(KX*(E(:,:,jcount)\KX)-I);
    [W(:,:,jcount),Q]=eig(EB);
    Q=sqrt(Q);
    q(:,jcount)=diag(Q);
    V(:,:,jcount)=E(:,:,jcount)\W(:,:,jcount)*Q;
    X(:,:,jcount)=diag(exp(-k0*q(:,jcount)*thickness(jcount)));
end

fg=[I;1i*ZL];
for icount=L-1:-1:2
    ab=[[-W(:,:,icount);V(:,:,icount)],fg]\...
        [W(:,:,icount)*X(:,:,icount);V(:,:,icount)*X(:,:,icount)];
    a(:,:,icount)=ab(1:twonmode1,:);
    b(:,:,icount)=ab(twonmode2:end,:);
    fg=[W(:,:,icount)*(I+X(:,:,icount)*a(:,:,icount));...
        V(:,:,icount)*(I-X(:,:,icount)*a(:,:,icount))];
end

MR=[[-I;1i*Z1],fg];
VR=zeros(fournmode2,1);
VR(nmode+1)=1;
VR(threenmode2)=1i/index(1,1)*cosd(incidentangle);
RT2=MR\VR;
R=RT2(1:twonmode1);

CP=zeros(twonmode1,L);  % C plus
CM=CP;                  % C minus
CP(:,2)=RT2(twonmode2:end);
CM(:,2)=a(:,:,2)*CP(:,2);
for icount=3:L-1
    CP(:,icount)=b(:,:,icount-1)*CP(:,icount-1);
    CM(:,icount)=a(:,:,icount)*CP(:,icount);
end
T=b(:,:,L-1)*CP(:,L-1);

mr.ComputingResults.k0=k0;
mr.ComputingResults.kx=kx;
mr.ComputingResults.kz1=kz1;
mr.ComputingResults.kzL=kzL;
mr.ComputingResults.R=R;
mr.ComputingResults.T=T;
mr.ComputingResults.CP=CP;
mr.ComputingResults.CM=CM;
mr.ComputingResults.W=W;
mr.ComputingResults.V=V;
mr.ComputingResults.q=q;
mr.ComputingResults.X=X;
mr.ComputingResults.Z1=Z1;
mr.ComputingResults.ZL=ZL;
mr.ComputingResults.I=I;
mr.ComputingResults.StackThickness=mr.Layers{end}.Thickness;
mr.ComputingResults.Time=toc(t1);