classdef RCWA < handle
    properties
        Name
        Polarization
        LightSource
        Period        
        ModeNumber
        IndexProfileResolution        
        LayerNumber
        Layers        
        FieldDetectorNumber
        FieldDetectors
        ComputingResults
        Reflection
        Transmission
    end
    methods
        function mr=RCWA(varargin)
            mr.Name='rcwa';
            mr.ModeNumber=50;
            mr.Period=800;
            mr.ComputingResults=Results;
            for icount=1:nargin
                if ischar(varargin{icount})
                    switch lower(varargin{icount})
                        case {'nm','name'}
                            mr.Name=varargin{icount+1};
                        case {'period','lambda'}
                            mr.Period=varargin{icount+1};
                        case {'nmode','modenumber'}
                            mr.ModeNumber=varargin{icount+1};
                        otherwise
                            disp('Error: Unknown input.');
                            return;
                    end
                end
            end
            mr.IndexProfileResolution=2^nextpow2(4*mr.ModeNumber+1);
            mr.FieldDetectorNumber=0;
            mr.LayerNumber=2;
            mr.Layers=cell(mr.LayerNumber,1);
            mr.Layers{1}=Layer('period',mr.Period,...
                'indresol',mr.IndexProfileResolution);
            mr.Layers{1}.SetThickness(0);
            mr.Layers{1}.SetLayerThickness(0);
            mr.Layers{2}=Layer('period',mr.Period,...
                'indresol',mr.IndexProfileResolution);
            mr.Layers{2}.SetThickness(0);
            mr.Layers{2}.SetLayerThickness(0);
        end
        function SetModeNumber(mr,nmode)
            mr.ModeNumber=nmode;
            mr.IndexProfileResolution=2^nextpow2(4*mr.ModeNumber+1);
            for icount=1:mr.LayerNumber
                mr.Layers{icount}.SetIndexProfileResolution(...
                    mr.IndexProfileResolution);
            end
        end
        function SetPeriod(mr,period)
            mr.Period=period;
            for icount=1:mr.LayerNumber
                mr.Layers{icount}.SetPeriod(...
                    mr.Period);
            end
        end
        function AddLayer(mr,varargin)
            mr.Layers{mr.LayerNumber+1}=mr.Layers{mr.LayerNumber};
            mr.Layers{mr.LayerNumber}=Layer('period',mr.Period,...
                'IndexProfileResolution',mr.IndexProfileResolution,...
                'lyt',0);
            if nargin>1
                for icount=1:2:nargin-1
                    if ischar(varargin{icount})
                        switch lower(varargin{icount})
                            case {'layerthick','layerthickness','lyt'}
                                mr.Layers{mr.LayerNumber}...
                                    .SetLayerThickness(...
                                    varargin{icount+1});
                            case {'nm','name'}
                                mr.Layers{mr.LayerNumber}.SetName(...
                                    varargin{icount+1});
                            case {'index','profile',...
                                    'indexprofile',...
                                    'profileparameters',...
                                    'indexprofileparameters'}
                                mr.Layers{mr.LayerNumber}...
                                    .SetIndexProfile(...
                                    varargin{icount+1});
                            otherwise
                                disp('Error: Unknown input.');
                                return;
                        end
                    end
                end
            end
            mr.Layers{mr.LayerNumber}.Thickness...
                =mr.Layers{mr.LayerNumber+1}.Thickness...
                +mr.Layers{mr.LayerNumber}.LayerThickness;
            mr.Layers{mr.LayerNumber+1}.Thickness...
                =mr.Layers{mr.LayerNumber+1}.Thickness...
                +mr.Layers{mr.LayerNumber}.LayerThickness;
            mr.LayerNumber=mr.LayerNumber+1;
        end
        function SetLayer(mr,varargin)
            if nargin==1
                disp('Error: Please specify the layer by index or name.');
            elseif mod(nargin,2)
                disp('Error: Input argument number incorrect.');
            else
                if ischar(varargin{1})
                    for icount=1:mr.LayerNumber
                        if strcmpi(mr.Layers{icount}.Name,varargin{1})
                            for jcount=2:2:nargin-1
															%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
															switch lower(varargin{jcount})
															    case {'nm','name'}
															        mr.Layers{icount}.Name=varargin{jcount+1};
															    case {'layerthick','layerthickness','lyt'}
															        delthick=varargin{jcount+1}-mr.Layers{icount}.LayerThickness;
															        mr.Layers{icount}.LayerThickness=varargin{jcount+1};
															        for kcount=icount+1:length(mr.Layers)
															            mr.Layers{kcount}.Thickness...
															                =mr.Layers{kcount}.Thickness+delthick;
															        end
															    case {'index','profile',...
															            'indexprofile',...
															            'profileparameters',...
															            'indexprofileparameters'}
															        mr.Layers{icount}.SetIndexProfile(varargin{jcount+1});
															    otherwise
															        disp('Error: Unknown input.');
															        return;
															end
															%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            end
                        end
                    end
                else
                    icount=varargin{1};
                    for jcount=2:2:nargin-1
                        switch lower(varargin{jcount})
                            case {'nm','name'}
                                mr.Layers{icount}.Name=varargin{jcount+1};
                            case {'layerthick','layerthickness','lyt'}
                                delthick=varargin{jcount+1}-...
                                    mr.Layers{icount}.LayerThickness;
                                mr.Layers{icount}.LayerThickness=...
                                    varargin{jcount+1};
                                for kcount=icount+1:length(mr.Layers)
                                    mr.Layers{kcount}.Thickness...
                                        =mr.Layers{kcount}.Thickness...
                                        +delthick;
                                end
                            case {'index','profile',...
                                    'indexprofile',...
                                    'profileparameters',...
                                    'indexprofileparameters'}
                                mr.Layers{icount}...
                                    .SetIndexProfile(varargin{jcount+1});
                            otherwise
                                disp('Error: Unknown input.');
                                return;
                        end
                    end
                end
            end
        end
        function ApplyLightSource(mr,varargin)
            mr.LightSource=Source;
            mr.Polarization=mr.LightSource.Polarization;
            mr.SetLightSource(varargin{:});
        end
        function SetLightSource(mr,varargin)
            if nargin==1
                return;
            else
                for icount=1:2:nargin-1
                    switch lower(varargin{icount})
                        case {'pol','polarization'}
                            mr.LightSource...
                                .SetPolarization(varargin{icount+1});
                            mr.Polarization=upper(varargin{icount+1});
                        case {'wv','wavelength'}
                            mr.LightSource...
                                .SetWavelength(varargin{icount+1});
                        case {'nm','name'}
                            mr.LightSource...
                                .SetName(varargin{icount+1});
                        case {'theta','incidentangle','angle'}
                            mr.LightSource...
                                .SetIncidentAngle(varargin{icount+1});
                        otherwise
                            disp('Error: Unrecoganized input.');
                            return;
                    end
                end
            end
        end
        function Run(mr)
            if strcmpi(mr.Polarization,'te')
                rcwate(mr);
                [mr.Reflection,mr.Transmission,...
                    mr.ComputingResults.DER,mr.ComputingResults.DET]...
                    =reflectionte(...
                    mr.ComputingResults.kz1,mr.ComputingResults.R,...
                    mr.ComputingResults.kzL,mr.ComputingResults.T);
            elseif strcmpi(mr.Polarization,'tm')
                rcwatm(mr);
                [mr.Reflection,mr.Transmission,...
                    mr.ComputingResults.DER,mr.ComputingResults.DET]...
                    =reflectiontm(...
                    mr.Layers{1}.IndexProfile(1)^2,...
                    mr.ComputingResults.kz1,mr.ComputingResults.R,...
                    mr.Layers{mr.LayerNumber}.IndexProfile(1)^2,...
                    mr.ComputingResults.kzL,mr.ComputingResults.T);
            else
                disp('Error: Unknown polarization.');
                return;
            end
        end
        function AddFieldDetector(mr,varargin)
            mr.FieldDetectorNumber=mr.FieldDetectorNumber+1;
            mr.FieldDetectors{mr.FieldDetectorNumber}=Detector;
            mr.SetFieldDetector(mr.FieldDetectorNumber,varargin{:});
        end
        function RemoveFieldDetector(mr,name)
            if ~ischar(name)
                disp('Error: Name must be a string.');
            elseif mr.FieldDetectorNumber<1
                disp('Error: No detector available.');
            else
                for icount=1:mr.FieldDetectorNumber
                    if strcmpi(mr.FieldDetectors{icount}.Name,name)
                        mr.FieldDetectors(icount)=[];
                        mr.FieldDetectorNumber=mr.FieldDetectorNumber-1;
                    else
                        disp(['Error: Cannot find detector named'...
                            name ' .']);
                    end
                end
            end
        end
        function SetFieldDetector(mr,varargin)
            if nargin==1
                disp(['Error: Please specify '...
                    'the detector by index or name.']);
                return;
            elseif nargin==2
                return;
            elseif mod(nargin,2)
                disp('Error: Input argument number incorrect.');
                return;
            else
                if ischar(varargin{1})
                    for jcount=1:length(mr.FieldDetectors)
                        if strcmpi(mr.FieldDetectors{jcount}.Name...
                                ,varargin{1})
                                for icount=2:2:nargin-1
                                    switch lower(varargin{icount})
                                        case {'nm','name'}
                                            mr.FieldDetectors{jcount}...
                                                .SetName(...
                                                lower(varargin{icount+1}));
                                        case {'status','st'}
                                            mr.FieldDetectors{jcount}...
                                                .SetStatus(...
                                                lower(varargin{icount+1}));
                                        case 'x'
                                            mr.FieldDetectors{jcount}...
                                                .SetX(varargin{icount+1});
                                        case 'z'
                                            mr.FieldDetectors{jcount}...
                                                .SetZ(varargin{icount+1});
                                        case {'xresol'...
                                                ,'xresolution','xres'}
                                            mr.FieldDetectors{jcount}...
                                                .SetXResolution(...
                                                varargin{icount+1});
                                        case {'zresol'...
                                                ,'zresolution','zres'}
                                            mr.FieldDetectors{jcount}...
                                                .SetZResolution(...
                                                varargin{icount+1});
                                        case {'modal','m'}
                                            mr.FieldDetectors{jcount}...
                                                .SetFieldModal(...
                                                lower(varargin{icount+1}));
                                        otherwise
                                            disp(['Error: Unrecogan'...
                                                'ized input.']);
                                            return;
                                    end
                                end
                        end
                    end
                else
                    jcount=varargin{1};
                    for icount=2:2:nargin-1
                        %%%%%%%%%%%%%%%%%%%%%%%%
												switch lower(varargin{icount})
												    case {'nm','name'}
												        mr.FieldDetectors{jcount}.SetName(varargin{icount+1});
												    case {'status','st'}
												        mr.FieldDetectors{jcount}.SetStatus(varargin{icount+1});
												    case 'x'
												        mr.FieldDetectors{jcount}.SetX(varargin{icount+1});
												    case 'z'
												        mr.FieldDetectors{jcount}.SetZ(varargin{icount+1});
												    case {'xresol','xresolution','xres'}
												        mr.FieldDetectors{jcount}.SetXResolution(varargin{icount+1});
												    case {'zresol','zresolution','zres'}
												        mr.FieldDetectors{jcount}.SetZResolution(varargin{icount+1});
												    case {'modal','m'}
												        mr.FieldDetectors{jcount}.SetFieldModal(varargin{icount+1});
												    otherwise
												        disp('Error: Unrecoganized input.');
												        return;
												end
												%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    end
                end
            end
        end
        function FieldPlot(mr,varargin)
            for icount=1:nargin-1
                if ischar(varargin{icount})
                    for jcount=1:length(mr.FieldDetectors)
                        if strcmpi(varargin{icount},...
                                mr.FieldDetectors{jcount}.Name)
                            if strcmpi(mr.FieldDetectors{jcount}...
                                    .DetectorType,'face')
                                hp=pcolor(mr.FieldDetectors{jcount}.Z,...
                                    mr.FieldDetectors{jcount}.X,...
                                    abs(mr.FieldDetectors{jcount}.Field).^2);
                                mr.FieldDetectors{jcount}...
                                    .FieldPlotHandle=hp;
                                set(hp,'EdgeColor','none');
                            else
                                if mr.FieldDetectors{jcount}.XResolution==1
                                    hp=plot(mr.FieldDetectors{jcount}.Z...
                                        ,abs(mr.FieldDetectors{jcount}.Field).^2,'LineWidth',2);
                                    mr.FieldDetectors{jcount}...
                                        .FieldPlotHandle=hp;
                                else
                                    hp=plot(mr.FieldDetectors{jcount}.X...
                                        ,abs(mr.FieldDetectors{jcount}.Field).^2,'LineWidth',2);
                                    mr.FieldDetectors{jcount}...
                                        .FieldPlotHandle=hp;
                                end
                            end
                        end
                    end
                else
                    jcount=varargin{icount};
                    if strcmpi(mr.FieldDetectors{jcount}...
                            .DetectorType,'face')
                        hp=pcolor(mr.FieldDetectors{jcount}.Z,...
                            mr.FieldDetectors{jcount}.X,...
                            abs(mr.FieldDetectors{jcount}.Field).^2);
                        mr.FieldDetectors{jcount}.FieldPlotHandle=hp;
                        set(hp,'EdgeColor','none');
                    else
                        if mr.FieldDetectors{jcount}.XResolution==1
                            hp=plot(mr.FieldDetectors{jcount}.Z,...
                                abs(mr.FieldDetectors{jcount}.Field).^2,'LineWidth',2);
                            mr.FieldDetectors{jcount}.FieldPlotHandle=hp;
                        else
                            hp=plot(mr.FieldDetectors{jcount}.X,...
                                abs(mr.FieldDetectors{jcount}.Field).^2,'LineWidth',2);
                            mr.FieldDetectors{jcount}.FieldPlotHandle=hp;
                        end
                    end
                end
            end
        end
        function FieldComputing(mr)
            if mr.FieldDetectorNumber~=0
                for icount=1:mr.FieldDetectorNumber
                    if strcmpi(mr.FieldDetectors{icount}.Status,'on')
                        fldcmp(mr,icount);
                    end
                end
            else
                disp('Warning: There is no field detector.');
            end
        end
        function StructureProfileSketch(mr,varargin)
            if mr.LayerNumber>2
                for icount=2:mr.LayerNumber-1
                    x1=mr.Layers{icount-1}.Thickness;
                    x2=mr.Layers{icount}.Thickness;
                    for jcount=1:length(...
                            mr.Layers{icount}.IndexProfileParameters)
                        y1=mr.Layers{icount}...
                            .IndexProfileParameters{jcount}(1);
                        y2=mr.Layers{icount}...
                            .IndexProfileParameters{jcount}(2);
                        if nargin>2
                            line([x1,x1,x2,x2,x1]...
                                ,[y1,y2,y2,y1,y1],varargin{1:end});
                        else
                            line([x1,x1,x2,x2,x1],[y1,y2,y2,y1,y1]);
                        end
                    end
                end
            else
                disp('Error: There is no layer structure.');
            end
            
        end
        function StructureIndexMap(mr)
            xresol=mr.IndexProfileResolution;
            dx=mr.Period/xresol;
            dz=dx;
            if mr.LayerNumber>2
                x1=-mr.Period/2;
                x2=mr.Period/2;
                if xresol>1
                    x=linspace(x1,x2,xresol+1)';
                    x(end)=[];
                else
                    x=x1;
                end
                X=[];
                Z=[];
                INDP=[];
                for icount=1:mr.LayerNumber
                    if icount==1
                        z1=-mr.Layers{mr.LayerNumber}.Thickness/4;
                    else
                        z1=mr.Layers{icount-1}.Thickness;
                    end
                    if icount==mr.LayerNumber
                        z2=mr.Layers{icount}.Thickness...
                            +mr.Layers{mr.LayerNumber}.Thickness/4;
                    else
                        z2=mr.Layers{icount}.Thickness;
                    end
                    zresol=round((z2-z1)/dz)+1;
                    if zresol>1
                        z=linspace(z1,z2,zresol)';
                    else
                        z=z1;
                    end
                    indp=mr.Layers{icount}.IndexProfile(:,ones(zresol,1));
                    xx=x(:,ones(length(z),1));
                    zz=z(:,ones(length(x),1))';
                    X=[X,xx];
                    Z=[Z,zz];
                    INDP=[INDP,indp];
                end
                hp=pcolor(Z,X,real(INDP));
                %alpha(hp,0.6);
                set(hp,'EdgeColor','none');
            else
                disp('Error: There is no layer structure.');
            end
        end
    end
end
