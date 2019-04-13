% hcgcavity
clear all; close all; clc;
wavelength=1550;
%wavelength=[630:0.2:633.4 633.5:0.005:634.1 634.2:0.2:637]; % for 237 nm
% the wavelength of the light in the air
incidentangle=[0:0.1:89];
%incidentangle=[0:0.1:5.95 5.96:0.001:6 6.1:0.1:33.5 33.6:0.001:33.7 33.8:0.1:49.6 49.66:0.001:49.73 49.8:0.1:89];
% the angle between the incident light and the normal direction of the
% layers, in degree
period=1820;
% the grating period
dutycycle=.66;
gratingthickness=340;
nmode=20;

nTiO2=2.2-0.0002j;
nSiO2=1.46-0.00003j;
substrateindex=1;
gratingindex=nSiO2;
dTiO2=84.3;  
dSiO2=175.6;

rcwa=RCWA('period',period,'modenumber',nmode);

rcwa.SetLayer(1,'index',1,'nAme','In');
rcwa.SetLayer(2,'index',1,'name','oUT');
rcwa.AddLayer('lYt',gratingthickness,...
    'profile',[-rcwa.Period/2*dutycycle,...
    rcwa.Period/2*dutycycle...
    ,1.46]);
% rcwa.AddLayer('lYt',gratingthickness,...
%     'profile',[-700,-200,1.46],'profile',[0,500,1.46]);


% rcwa.AddLayer('lyt',500,'index',1);

rcwa.AddLayer('lYt',175,'index',1.62);
for icount=1:3
    rcwa.AddLayer('lyt',580,'index',1.24);
    rcwa.AddLayer('lyt',340,'index',1.79);
end
rcwa.AddLayer('lyt',580,'index',1.24);
rcwa.AddLayer('lyt',450,'index',1.79);

for i=1:length(incidentangle)
    %rcwa.LightSource.SetPolarization('TM');
    %rcwa.LightSource.SetWavelength(wavelength);
    %rcwa.LightSource.SetIncidentAngle(incidentangle);
    rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle(i));
    rcwa.Run;

    r(i)=rcwa.Reflection;
    t(i)=rcwa.Transmission;
    % Reflection and transmission coefficients

%     if i==46
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
ss = get(0,'ScreenSize');
figure('Position',[1 0.056*ss(4)/4 ss(3)/4 0.87*ss(4)/2]);
%plot(incidentangle,r,incidentangle,t,'r',incidentangle,1-r-t,'k')
plot(incidentangle,r)
%axis([635.25 635.55 0 1])

% figure('Position',[1 0.056*ss(4)/4 ss(3)/4 0.87*ss(4)/2]);
% figure(2)
% subplot(2,1,1);rcwa.FieldPlot(1);
% subplot(2,1,2);rcwa.StructureIndexMap;