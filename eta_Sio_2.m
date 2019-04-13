function etaSio2 = eta_Sio_2(lambd)
    lamb = lambd*1e-03;
    etaSio2 = sqrt(1 + 0.6961663*lamb^2/(lamb^2-0.0684043^2) + 0.4079426*lamb^2/(lamb^2-0.1162414^2) + 0.8974794*lamb^2/(lamb^2-9.896161^2) - 0.0001i); 
   
end