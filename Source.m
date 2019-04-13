classdef Source < handle
    properties
        Name
        Polarization
        Wavelength
        IncidentAngle
    end
    methods
        function sr=Source
            sr.Name='sr';
            sr.Polarization='TE';
            sr.Wavelength=800;
            sr.IncidentAngle=0;
        end
        function SetName(sr,name)
            if ~ischar(name)
                disp('Error: Name must be a string.');
            else
                sr.Name=name;
            end
        end
        function SetPolarization(sr,polarization)
            switch lower(polarization)
                case {'te','tm'}
                    sr.Polarization=upper(polarization);
                case 'conical'
                    disp('Info: We do not have conical funcationality yet.');
                otherwise
                    disp('Error: Unrecoganized polarization.');
            end
        end
        function SetWavelength(sr,wavelength)
            sr.Wavelength=wavelength;
        end
        function SetIncidentAngle(sr,incidentangle)
            sr.IncidentAngle=incidentangle;
        end
    end
end