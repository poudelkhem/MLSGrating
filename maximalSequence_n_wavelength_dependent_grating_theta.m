
clear all; close all; clc;
wavelength=485;%1160;

% the wavelength of the light in the air
incidentangle=linspace(31,32,500);

% the angle between the incident light and the normal direction of the
% layers, in degree
period=442.25;%929.16;
% the grating period
dutycycle=0.5;
gratingthickness=30.0;
nmode=11;

dn = 0.0;

nTiO2=sqrt(4.84-0.0007i);%nTiO2w(wavelength);
nSiO2=sqrt(2.1316-0.0001i);%nSiO2w(wavelength);
substrateindex=1.0+dn;
superstrateindex=1.34+dn;
gratingindex=nTiO2+0.01;
dTiO2=71.9;  
dSiO2=108.4;

rcwa=RCWA('period',period,'modenumber',nmode);
rcwa.SetLayer(2,'index',substrateindex,'name','out');
 rcwa.SetLayer(1,'index',superstrateindex,'nAme','in');

rcwa.AddLayer('lYt',gratingthickness,...
    'profile',[-rcwa.Period, -rcwa.Period/2*dutycycle, superstrateindex],...
    'profile',[-rcwa.Period/2*dutycycle,rcwa.Period/2*dutycycle,gratingindex],...
    'profile',[rcwa.Period/2*dutycycle, rcwa.Period, superstrateindex]);

%  rcwa.AddLayer('lYt',gratingthickness,...
%     'profile',[-rcwa.Period, -rcwa.Period/2*dutycycle, gratingindex],...
%     'profile',[-rcwa.Period/2*dutycycle, rcwa.Period/2*dutycycle, superstrateindex],...
%     'profile',[rcwa.Period/2*dutycycle, rcwa.Period, gratingindex]);

% rcwa.AddLayer('lyt',5*dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',2*dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',2*dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',2*dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',4*dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',3*dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',2*dTiO2,'index',nTiO2+dn);
% rcwa.AddLayer('lyt',3*dSiO2,'index',nSiO2+dn);
% rcwa.AddLayer('lyt',5*dTiO2,'index',nTiO2+dn);

rcwa.AddLayer('lyt',dTiO2,'index',nTiO2+0.01);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

for j=1:length(incidentangle)
%     rcwa.LightSource.SetPolarization('TM');
%     rcwa.LightSource.SetWavelength(wavelength);
%     rcwa.LightSource.SetIncidentAngle(incidentangle);
%     rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle);
    rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle(j));
    rcwa.Run;

    r(j)=rcwa.Reflection;
    t(j)=rcwa.Transmission;
%     Reflection and transmission coefficients

%     if i==519%5356%5368
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
% plot(incidentangle,r)
% xlabel('Angle of Incidence \theta (degrees)')
% ylabel('Reflectivity')
% set(findall(gcf,'type','text'),'FontSize',12)
% set(gca,'YDir','normal')
% axis tight
% 
% % plot(wavelength,r)
% % xlabel('Wavelength \lambda (nm)')
% % ylabel('Reflectivity')
% % set(findall(gcf,'type','text'),'FontSize',12)
% % set(gca,'YDir','normal')
% % axis tight
% %axis([635.25 635.55 0 1])
% % 
% 

figure(1)
plot(incidentangle,t,'b',incidentangle,r,'r');

[a, b]=min(r);
rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle(b));
rcwa.Run;
rcwa.AddFieldDetector;
rcwa.SetFieldDetector(1,'x',linspace(-rcwa.Period,rcwa.Period,100),...
    'z',linspace(-rcwa.ComputingResults.StackThickness/4,...
    rcwa.ComputingResults.StackThickness*5/4,800),'modal','scatter');
rcwa.AddFieldDetector('x',0,'z',linspace(...
    -rcwa.ComputingResults.StackThickness/4,...
    rcwa.ComputingResults.StackThickness*5/4,800));


rcwa.FieldComputing;

h=figure(2);
subplot(3,1,1);rcwa.FieldPlot(1);
subplot(3,1,2);rcwa.StructureIndexMap;
subplot(3,1,3);rcwa.FieldPlot(2);
axis tight;

%surf(r);shading interp
% % % % save the plot in pdf format
% set(h,'Units','Inches');
% pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(h,'fibonacci_field_amp','-dpdf','-r0')