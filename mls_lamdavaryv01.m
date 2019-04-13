% *****************   MLS   Design*********************
%@ Khem N poudel, Date 06/25/2017,MTSU

%************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Defining all the variables and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 close all; clc;clear all; 
 %Incident angle between normal and incident light
 incangle=linspace(0,90,200);
  %Operating Wavelength
 %lambda=632.8;
 lambda=linspace(400,800,100);
 % Refractive Index 
 eta_air=1.0;
 eta_Sio2=1.45;
 eta_subtrate=1.0;
 eta_superstrate=1.45;
 %  The Grating Period is the  Period of whole structure
 period=800; 
 nmode=11;
 %Thickness of structure
 d_air=200;
 d_Sio2=200;
 % Grating Structure
dutycycle=0.5;
gratingthickness=40.0;

 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   RCWA Implementation For m=5 or N=31 MLS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 rcwa=RCWA('period',period,'modenumber',nmode);
 rcwa.SetLayer(2,'index',eta_subtrate,'name','out');
 rcwa.SetLayer(1,'index',eta_superstrate,'nAme','in'); 
 
 rcwa.AddLayer('lyt',5*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',2*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',2*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',1*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',1*d_Sio2,'index',eta_Sio2); 
 rcwa.AddLayer('lyt',2*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',1*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',4*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',1*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',1*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',1*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',1*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',3*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',1*d_air,'index',eta_air);
 rcwa.AddLayer('lyt',2*d_Sio2,'index',eta_Sio2);
 rcwa.AddLayer('lyt',3*d_air,'index',eta_air);
 
  
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
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Plot  reflection Coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
 plot(incangle,refln,'r-',incangle,trans,'b-','LineWidth',3,'MarkerSize',8)
 legend('Reflection','Transmission ')
 xlabel('Incident angle  \theta (degrees)')
 ylabel('Reflection/Transmission Coeff.');
 set(findall(gcf,'type','text'),'FontSize',16);
 set(gca,'YDir','normal');
 axis tight;
%  figure(2);
% 
%  plot(incangle,trans,'b-','LineWidth',3,'MarkerSize',8)
%  xlabel('Incident angle  \theta (degrees)')
%  ylabel('Transmission Coeff.');
%  set(findall(gcf,'type','text'),'FontSize',16);
%  set(gca,'YDir','normal');
%  axis tight;
 
 
     
    [minval, ind]=min(refln);
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
    axis tight;
    
    
    