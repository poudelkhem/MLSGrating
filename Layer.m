classdef Layer < handle
    properties
        Name
        Period
        IndexProfile
        IndexProfileParameters
        IndexProfileResolution
        LayerThickness
        Thickness
    end
    methods
        function ly=Layer(varargin)
            ly.Name='layer';
            for icount=1:nargin
                if ischar(varargin{icount})
                    switch lower(varargin{icount})
                        case {'nm','name'}
                            ly.Name=varargin{icount+1};
                        case {'layerthick','layerthickness','lyt'}
                            ly.LayerThickness=varargin{icount+1};
                        case {'period','lambda'}
                            ly.Period=varargin{icount+1};
                            ly.IndexProfileParameters{1}...
                                =[-ly.Period/2,ly.Period/2,1];
                        case {'resol','indexprofileresolution','indresol'}
                            ly.IndexProfileResolution=varargin{icount+1};
                        case {'index','profile',...
                                'indexprofile',...
                                'profileparameters',...
                                'indexprofileparameters'}
                            if length(varargin{icount+1})==1
                                ly.IndexProfileParameters{1}...
                                    =[-ly.Period/2,ly.Period/2,1]...
                                    *varargin{icount+1};
                            else
                                ly.IndexProfileParameters{end+1}...
                                    =varargin{icount+1};
                            end
                        otherwise
                            disp('Error: Unknown input.');
                            return;
                    end
                end
            end
            ly.SetIndexProfile;
        end
        function SetPeriod(ly,period)
            ly.Period=period;
            ly.IndexProfileParameters{1}...
                =[-ly.Period/2,ly.Period/2,1];
            ly.SetIndexProfile;
        end
        function SetName(ly,name)
            if ~ischar(name)
                disp('Error: Name must be a string.');
            else
                ly.Name=name;
            end
        end
        function SetLayerThickness(ly,layerthick)
            ly.LayerThickness=layerthick;
        end
        function SetThickness(ly,thick)
            ly.Thickness=thick;
        end
        function SetIndexProfileResolution(ly,indresol)
            ly.IndexProfileResolution=indresol;
            ly.SetIndexProfile;
        end
        function SetIndexProfile(ly,varargin)
            if nargin==1
                paranum=length(ly.IndexProfileParameters);
                ly.IndexProfile=ones(ly.IndexProfileResolution+1,1);
                delx=ly.Period/ly.IndexProfileResolution;
                x1=-ly.Period/2;
                for icount=1:paranum
                    l1=round((...
                        ly.IndexProfileParameters{icount}(1)-x1)/delx)+1;
                    l2=round((...
                        ly.IndexProfileParameters{icount}(2)-x1)/delx)+1;
                    ly.IndexProfile(l1:l2)...
                        =ones(l2-l1+1,1)...
                        *ly.IndexProfileParameters{icount}(3);
                end
                ly.IndexProfile(end)=[];
            elseif nargin==2 && length(varargin{1})==1
                ly.IndexProfile=ones(ly.IndexProfileResolution,1)...
                    *varargin{1};
                ly.IndexProfileParameters{1}(3)=varargin{1};
                paranum=length(ly.IndexProfileParameters);
                if paranum>1
                    for icount=paranum:-1:2
                        ly.IndexProfileParameters(icount)=[];
                    end
                end
            else
                paranum=length(ly.IndexProfileParameters);
                delx=ly.Period/ly.IndexProfileResolution;
                x1=-ly.Period/2;
                for icount=1:nargin-1
                    v1=varargin{icount}(1);
                    v2=varargin{icount}(2);
                    if v2<v1
                        disp(['Error: the '...
                            num2str(icount+1) 'th input error']);
                        return;
                    end
                    if v1>=ly.Period/2 || v2<-ly.Period/2
                        continue;
                    end
                    if v1<-ly.Period/2
                        v1=-ly.Period/2;
                    end
                    if v2>ly.Period/2
                        v2=ly.Period/2;
                    end
                    ly.IndexProfileParameters{paranum+icount}(1)=v1;
                    ly.IndexProfileParameters{paranum+icount}(2)=v2;
                    ly.IndexProfileParameters{paranum+icount}(3)=...
                        varargin{icount}(3);
                    l1=round((...
                        ly.IndexProfileParameters{end}(1)-x1)/delx)+1;
                    l2=round((...
                        ly.IndexProfileParameters{end}(2)-x1)/delx)+1;
                    if l2>ly.IndexProfileResolution
                        l2=l2-1;
                    end
                    ly.IndexProfile(l1:l2)...
                        =ones(l2-l1+1,1)...
                        *ly.IndexProfileParameters{end}(3);
                end
            end
        end
    end
end