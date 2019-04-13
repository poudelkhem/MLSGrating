% *****************   MLS   Design*********************
%@ Khem N poudel, Date 06/25/2017,MTSU

%************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Defining all the variables and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 close all; clc;clear all; 
 %Incident angle between normal and incident light
 %incangle=linspace(0,90,200);%[44.5:0.005:65];
 incangle=30.95;
 
 %Operating WAVELENGTH
 lambda=linspace(450,900,200);
 % Refractive Index 
 eta_air=1.0;
 eta_Sio2=1.45;
 %eta_Sio2=eta_Sio_2(lambda);
 eta_subtrate=1.0;
 eta_superstrate=1.45;
 %  The Grating Period is the  Period of whole structure
 period=700; 
 nmode=11;
 %Thickness of structure
 d_air=100;
 d_Sio2=200;
 % Grating Structure
 gratingindex=eta_Sio2;
 dutycycle=0.5;
 gratingthickness=300.0;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   RCWA Implementation For m=5 or N=31 MLS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 rcwa=RCWA('period',period,'modenumber',nmode);
 rcwa.SetLayer(2,'index',eta_subtrate,'name','out');
 rcwa.SetLayer(1,'index',eta_superstrate,'nAme','in'); 
 
 rcwa.AddLayer('lYt',gratingthickness,...
    'profile',[-rcwa.Period, -rcwa.Period/2*dutycycle, eta_superstrate],...
    'profile',[-rcwa.Period/2*dutycycle,rcwa.Period/2*dutycycle,gratingindex],...
    'profile',[rcwa.Period/2*dutycycle, rcwa.Period, eta_superstrate]);

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

for i=1:length(lambda)
 
%  for i=1:length(incangle)
    rcwa.ApplyLightSource('poL','Te','wV',lambda(i),'angle',incangle);
        rcwa.Run;
% Reflection and transmission coefficients
        refln(i)=rcwa.Reflection;
        trans(i)=rcwa.Transmission;
        
        
        
end
 
        [minval, ind]=min(refln);
        disp(ind)
       
            rcwa.ApplyLightSource('poL','Te','wV',lambda(ind),'angle',incangle);
        rcwa.Run;
        rcwa.AddFieldDetector;
        rcwa.SetFieldDetector(1,'x',linspace(-rcwa.Period,rcwa.Period,100),...
            'z',linspace(-rcwa.ComputingResults.StackThickness/4,...
            rcwa.ComputingResults.StackThickness*5/4,800),'modal','scatter');
        rcwa.AddFieldDetector('x',0,'z',linspace(...
            -rcwa.ComputingResults.StackThickness/4,...
            rcwa.ComputingResults.StackThickness*5/4,800));


        rcwa.FieldComputing;
    
        
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Plot  reflection Coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
 plot(lambda,refln,'r-',lambda,trans,'b-','LineWidth',3,'MarkerSize',8)
 legend('Reflection','Transmission ')
 xlabel('Wavelength[nm]')
 ylabel('Reflection/Transmission Coeff.');
 set(findall(gcf,'type','text'),'FontSize',16);
 set(gca,'YDir','normal');
 axis tight;
   


    
    figure(2);
    subplot(3,1,1);rcwa.FieldPlot(1);
    subplot(3,1,2);rcwa.StructureIndexMap;
    subplot(3,1,3);rcwa.FieldPlot(2);
     ylabel('|E|\^2)')
 xlabel('Thicknesss [nm].');
 set(findall(gcf,'type','text'),'FontSize',16);
 set(gca,'YDir','normal');
    axis tight;
    axis tight;
    
    
    