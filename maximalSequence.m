
    clear all; close all; clc;
%     wavelength=965.77;
     wavelength=1159.98;
    %wavelength=[630:0.2:633.4 633.5:0.005:634.1 634.2:0.2:637]; % for 237 nm
    % the wavelength of the light in the air
    incidentangle=linspace(65,80,2000);%[44.5:0.005:65];
    %incidentangle=[0:0.5:29 30:0.01:50 51:1:89];
    %incidentangle=[0:1:5 5.5:0.01:10 10.5:1:55.5 56:0.01:75 75:1:89];
    %incidentangle=[0:0.5:6 6.1:0.01:7.5 8:0.5:76.5 77:0.01:77.5 78:0.5:89];
    %incidentangle=[0:0.1:5.95 5.96:0.001:6 6.1:0.1:33.5 33.6:0.001:33.7 33.8:0.1:49.6 49.66:0.001:49.73 49.8:0.1:89];
    % the angle between the incident light and the normal direction of the
    % layers, in degree
    period=1;
    % the grating period
    %dutycycle=0.95;
    %gratingthickness=100.0;
    nmode=11;

    nTiO2=eta_Sio_2(wavelength);
 
    nSiO2=eta_Tio_2(wavelength);
    substrateindex=1.37;
    superstrateindex=1.5;
    %gratingindex=1.44;
    %defectheight=270.42;
    dTiO2=230;%195;  
    dSiO2=503;%260.3;

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
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % 
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    % 
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',5*dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',3*dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',2*dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',3*dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',4*dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',2*dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',2*dTiO2,'index',nTiO2);

    rcwa.AddLayer('lyt',2*dSiO2,'index',nSiO2);

    rcwa.AddLayer('lyt',5*dTiO2,'index',nTiO2);

    %  rcwa.SetLayer(1,'index',1,'nAme','In');
    %   rcwa.SetLayer(2,'index',substrateindex,'name','oUT');
    % % rcwa.AddLayer('lyt',500,'index',1);
    % 
    % rcwa.AddLayer('lYt',dTiO2,'index',nTiO2);
    % for icount=1:9
    %     rcwa.AddLayer('lyt',dSiO2,'index',nSiO2);
    %     rcwa.AddLayer('lyt',dTiO2,'index',nTiO2);
    % end
    % rcwa.AddLayer('ly0.01t',defectheight,'index',nSiO2);
    % rcwa.AddLayer('lYt',gratingthickness,...
    %     'profile',[-rcwa.Period/2*dutycycle,...
    %     rcwa.Period/2*dutycycle...
    %     ,gratingindex],'name','hcg-grating');

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
