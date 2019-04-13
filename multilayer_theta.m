% hcgcavity
%clear all; close all; clc;
wavelength=900;
%wavelength=[630:0.2:633.4 633.5:0.005:634.1 634.2:0.2:637]; % for 237 nm
% the wavelength of the light in the air
incidentangle=[45:0.1:65];
%incidentangle=[0:0.1:5.95 5.96:0.001:6 6.1:0.1:33.5 33.6:0.001:33.7 33.8:0.1:49.6 49.66:0.001:49.73 49.8:0.1:89];
% the angle between the incident light and the normal direction of the
% layers, in degree
period=1200;
% the grating period
dutycycle=.9;
gratingthickness=50;
nmode=20;

nTiO2 = sqrt(4.48)-0.00071j;
nSiO2= sqrt(2.1316)-0.0001j;
substrateindex=sqrt(2.25);
gratingindex=nSiO2;
dTiO2=177.17;  
dSiO2=256.84;

rcwa=RCWA('period',period,'modenumber',nmode);

 rcwa.SetLayer(1,'index',substrateindex,'nAme','In');
  rcwa.SetLayer(2,'index',1.19,'name','oUT');
% rcwa.AddLayer('lyt',500,'index',1);

rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lYt',dSiO2,'index',nSiO2);
% for icount=1:2
%     rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
%     rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
% end
% rcwa.AddLayer('lyt',241,'index',nSiO2);
%rcwa.AddLayer('lYt',gratingthickness,...
%    'profile',[-rcwa.Period/2*dutycycle,...
%    rcwa.Period/2*dutycycle...
%    ,gratingindex],'name','hcg-grating');

for i=1:length(incidentangle)
    %rcwa.LightSource.SetPolarization('TM');
    %rcwa.LightSource.SetWavelength(wavelength);
    %rcwa.LightSource.SetIncidentAngle(incidentangle);
    rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle(i));
    rcwa.Run;

    r(i)=rcwa.Reflection;
    t(i)=rcwa.Transmission;
    % Reflection and transmission coefficients
% 
%     if i==1730% 1767
%         rcwa.AddFieldDetector;
%         rcwa.SetFieldDetector(1,'x',linspace(-rcwa.Period,rcwa.Period,100),...
%             'z',linspace(-rcwa.ComputingResults.StackThickness/4,...
%             rcwa.ComputingResults.StackThickness*5/4,800),'modal','scatter');
%         rcwa.AddFieldDetector('x',0,'z',linspace(...
%             -rcwa.ComputingResults.StackThickness/4,...
%             rcwa.ComputingResults.StackThickness*5/4,800));
% 
% 
%         rcwa.FieldComputing;
%     end
end
%ss = get(0,'ScreenSize');
%figure('Position',[1 0.056*ss(4)/4 ss(3)/4 0.87*ss(4)/2]);
%plot(incidentangle,r,incidentangle,t,'r',incidentangle,1-r-t,'k')
plot(incidentangle,r)
%axis([635.25 635.55 0 1])

% figure(2)
% subplot(2,1,1);rcwa.FieldPlot(1);
% subplot(2,1,2);rcwa.StructureIndexMap;