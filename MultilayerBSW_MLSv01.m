% *****************   Flow Cell System   Design*********************
%@ Khem N poudel, Date 08/10/2018,MTSU

%************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Defining all the variables and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 close all; clc;clear all; 
 %Incident angle between normal and incident light
  incangle=linspace(63.3,64,500);
 
%incangle=29.8;
  %Operating Wavelength
 lambda=635;
 %lambda=linspace(400,800,100);
 % Refractive Index 
 
  eta_SiO2=eta_Sio_2(lambda);
  eta_SiO2=eta_SiO2++0.0001j;
 eta_Tio2=eta_Tio_2(lambda)+-0.00071j;
%  eta_air=eta_SiO2;%Equivalent eta_Si02
 %Thickness of structure
 d_air=200;%Equivalent d_Si02
%  eta_SiO2=1.457+0.0001j;
%  eta_Tio2=2.3-0.00071j;
 eta_subtrate=1.33;
 eta_superstrate=1.5;
 %  The Grating Period is the  Period of whole structure
 period=700; 
 nmode=11;
%  d_SiO2=182.4;
%  d_TiO2=117.3;
%  d_SiO21=157;

 d_TiO2=135;
 d_SiO2=216;
 d_SiO21=615.0;
 d_TiO21=128;
 % Grating Structure
% Grating Structure
 gratingindex=eta_Tio2+0.2;
 dutycycle=0.5;
 gratingthickness=300.0;
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   RCWA Implementation For BSW Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 rcwa=RCWA('period',period,'modenumber',nmode);
 rcwa.SetLayer(2,'index',eta_subtrate,'name','out');
 rcwa.SetLayer(1,'index',eta_superstrate,'nAme','in');
%  rcwa.AddLayer('lYt',gratingthickness,...
%     'profile',[-rcwa.Period, -rcwa.Period/2*dutycycle, eta_superstrate],...
%     'profile',[-rcwa.Period/2*dutycycle,rcwa.Period/2*dutycycle,gratingindex],...
%     'profile',[rcwa.Period/2*dutycycle, rcwa.Period, eta_superstrate]);
%  
rcwa.AddLayer('lYt',5*d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',3*d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',2*d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',3*d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',4*d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',2*d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',d_SiO2,'index',eta_SiO2);
 rcwa.AddLayer('lYt',2*d_TiO2,'index',eta_Tio2);
 rcwa.AddLayer('lYt',2*d_SiO2,'index',eta_SiO2);


  rcwa.AddLayer('lYt',d_SiO21,'index',eta_SiO2);% Extra SiO2

  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Run rcwa. This will calculate all the reflection, transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 for i=1:length(incangle)
    rcwa.ApplyLightSource('poL','Te','wV',lambda,'angle',incangle(i));
        rcwa.Run;
% Reflection and transmission coefficients
        refln(i)=rcwa.Reflection;
        trans(i)=rcwa.Transmission;
 end
%   save REFS134.txt refln -ascii
%   REFS625=load ("REFS130.txt");
%    REFS635=load ("REFS132.txt");
%    REFS650=load ("REFS134.txt");
%    REFS650=load ("REFS13420.txt");
%  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Plot  reflection Coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k=linspace(0,1e-04,1000);
% [X,Y] = meshgrid(incangle,k);
% surf(X,Y,refln)
figure(1);
 
plot(incangle,refln,'r','LineWidth',3,'MarkerSize',3)

% legend('R.I. 1.34000 ')
%   plot(incangle,REFS625,'r:',incangle,REFS635,'b--',incangle,REFS650,'k','LineWidth',3,'MarkerSize',3)
%  legend('R.I.= 1.30','R.I.= 1.32 ','R.I.= 1.34')
%   plot(incangle,REFS625,'r-',incangle,REFS635,'b',incangle,REFS650,'k','LineWidth',3,'MarkerSize',3)
%  legend('1.3400','1.3410 ','1.3420 ')
 xlabel('\theta (deg)')
 ylabel('Reflectivity.');
 set(findall(gcf,'type','text'),'FontSize',28);
 set(gca,'YDir','normal');
%  axis tight;
 figure(2);

 plot(incangle,trans,'b-','LineWidth',3,'MarkerSize',8)
 xlabel('Incident angle  \theta (degrees)')
 ylabel('Transmission Coeff.');
 set(findall(gcf,'type','text'),'FontSize',16);
 set(gca,'YDir','normal');
 axis tight;
 
 
     
    [minval, ind]=min(refln);
    disp(ind);
    rcwa.ApplyLightSource('poL','Te','wV',lambda,'angle',incangle(ind));
    rcwa.Run;
    rcwa.AddFieldDetector;
    rcwa.SetFieldDetector(1,'x',linspace(-rcwa.Period,rcwa.Period,100),...
        'z',linspace(-rcwa.ComputingResults.StackThickness/4,...
        rcwa.ComputingResults.StackThickness*5/4,800),'modal','scatter');
    rcwa.AddFieldDetector('x',0,'z',linspace(...
        -rcwa.ComputingResults.StackThickness/4,...
        rcwa.ComputingResults.StackThickness*5/4,800));


    rcwa.FieldComputing;
    figure(2);
    subplot(3,1,1);rcwa.FieldPlot(1);
    subplot(3,1,2);rcwa.StructureIndexMap;
    subplot(3,1,3);rcwa.FieldPlot(2);
    ylabel('|E|\^2)')
 xlabel('Thicknesss [nm].');
 set(findall(gcf,'type','text'),'FontSize',16);
 set(gca,'YDir','normal');
    axis tight;
  
   
    
    