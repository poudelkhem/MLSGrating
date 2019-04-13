classdef Results < handle
    properties
        k0      
        kx
        kz1
        kzL
        R       % reflection Bloch modes' coefficients
        T       % transmission Bloch modes' coefficients
        CP
        CM
        W
        V
        q
        X
        Y1
        YL
        Z1
        ZL
        I
        DER     % reflection diffraction efficiency
        DET     % tansmission diffraction efficiency
        Time    % time spent on coefficients computation
        StackThickness  % total stack thickness
    end
    methods
        function rt=Results
            rt.k0=0;
            rt.kx=0;
            rt.kz1=0;
            rt.kzL=0;
            rt.R=0;
            rt.T=0;
            rt.CP=0;
            rt.CM=0;
            rt.W=0;
            rt.V=0;
            rt.q=0;
            rt.X=0;
            rt.Y1=0;
            rt.YL=0;
            rt.Z1=0;
            rt.ZL=0;
            rt.I=0;
            rt.Time=0;
            rt.StackThickness=0;
        end
    end
end