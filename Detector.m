classdef Detector < handle
    properties
        Name
        Status
        DetectorType
        X
        Z
        XResolution
        ZResolution
        Field
        FieldModal
        FieldPlotHandle
    end
    methods
        function fd=Detector
            fd.Name='fd';
            fd.Status='on';
            fd.DetectorType='point';
            fd.X=0;
            fd.Z=0;
            fd.XResolution=1;
            fd.ZResolution=1;
            fd.Field=0;
            fd.FieldModal='scatter';
            fd.FieldPlotHandle=0;
        end
        function SetX(fd,x)
            sx=size(x);
            if sx(2)>1
                fd.X=x';
            else
                fd.X=x;
            end
            fd.XResolution=length(fd.X);
            if fd.XResolution==1 && fd.ZResolution==1
                fd.DetectorType='point';
            elseif fd.XResolution==1 || fd.ZResolution==1
                fd.DetectorType='line';
            else
                fd.DetectorType='face';
            end
        end
        function SetZ(fd,z)
            sz=size(z);
            if sz(2)>1
                fd.Z=z';
            else
                fd.Z=z;
            end
            fd.ZResolution=length(fd.Z);
            if fd.XResolution==1 && fd.ZResolution==1
                fd.DetectorType='point';
            elseif fd.XResolution==1 || fd.ZResolution==1
                fd.DetectorType='line';
            else
                fd.DetectorType='face';
            end
        end
        function SetXResolution(fd,xresol)
            if fd.XResolution==1 && xresol~=1
                disp('Error: Invalid resolution.');
            elseif fd.XResolution>1 && xresol==1
                disp('Error: Invalid resolution.');
            else
                fd.X=linspace(fd.X(1),fd.X(end),xresol)';
                fd.XResolution=xresol;
            end
        end
        function SetZResolution(fd,zresol)
            if fd.ZResolution==1 && zresol~=1
                disp('Error: Invalid resolution.');
            elseif fd.ZResolution>1 && zresol==1
                disp('Error: Invalid resolution.');
            else
                fd.Z=linspace(fd.Z(1),fd.Z(end),zresol)';
                fd.ZResolution=zresol;
            end
        end
        function SetStatus(fd,status)
            if strcmpi(status,'on') || strcmpi(status,'off')
                fd.Status=lower(status);
            else
                disp('Error: Status should be on or off.');
                return;
            end
        end
        function FieldPlot(fd)
            fd.FieldPlotHandle=pcolor(fd.X,fd.Z,fd.Field);
            set(fd.FieldPlotHandle,'EdgeColor','none');
        end
        function SetName(fd,name)
            if ~ischar(name)
                disp('Error: Name must be a string.');
            else
                fd.Name=name;
            end
        end
        function SetFieldModal(fd,modal)
            fd.FieldModal=lower(modal);
        end
    end
end