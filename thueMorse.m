clear all; close all; clc;
wavelength=485;%560;
% the wavelength of the light in the air
incidentangle=linspace(60,64,2000);%[44.5:0.005:65];
% the angle between the incident light and the normal direction of the
% layers, in degree
period=1;
% the grating period
%dutycycle=0.95;
%gratingthickness=100.0;
nmode=11;

nTiO2=sqrt(4.84-0.0007i);%3.54;%-0.0001j;
nSiO2=sqrt(2.1316-0.0001i);%1.56;%-0.00003j;
substrateindex=1.32;
superstrateindex=1.5;
%gratingindex=1.44;
%defectheight=270.42;
dTiO2=71.9;%195;  
dSiO2=108.4;%260.3;

rcwa=RCWA('period',period,'modenumber',nmode);
rcwa.SetLayer(2,'index',substrateindex,'name','out');
 rcwa.SetLayer(1,'index',superstrateindex,'nAme','in');
 
%  rcwa.AddLayer('lYt',gratingthickness,...
%     'profile',[-rcwa.Period/2*dutycycle,...
%     rcwa.Period/2*dutycycle...
%     ,gratingindex],'name','hcg-grating');
% rcwa.AddLayer('lyt',defectheight,'index',nSiO2);
% 
% % rcwa.AddLayer('lyt',500,'index',1);
% 
% rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
% for icount=1:6
%     rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
%     rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
% end
rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
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

%for i=1:length(wavelength)
for i=1:length(incidentangle)
    %rcwa.LightSource.SetPolarization('TM');
    %rcwa.LightSource.SetWavelength(wavelength);
    %rcwa.LightSource.SetIncidentAngle(incidentangle);
    %rcwa.ApplyLightSource('poL','Te','wV',wavelength(i),'angle',incidentangle);
    rcwa.ApplyLightSource('poL','Te','wV',wavelength,'angle',incidentangle(i));
    rcwa.Run;

    r(i)=rcwa.Reflection;
    t(i)=rcwa.Transmission;
    % Reflection and transmission coefficients

%     if i==511%5356%5368
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
xlabel('Angle of Incidence \theta (degrees)')
ylabel('Reflectivity')
set(findall(gcf,'type','text'),'FontSize',12)
set(gca,'YDir','normal')
axis tight

% plot(wavelength,r)
% xlabel('Wavelength \lambda (nm)')
% ylabel('Reflectivity')
% set(findall(gcf,'type','text'),'FontSize',12)
% set(gca,'YDir','normal')
% axis tight
%axis([635.25 635.55 0 1])
% 
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

% % % % save the plot in pdf format
% set(h,'Units','Inches');
% pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(h,'fibonacci_field_amp','-dpdf','-r0')