function etaTio2 = eta_Tio_2(lambd)
    lamb = lambd*1e-03;
    etaTio2 = sqrt(5.913 + 0.2441/(lamb^2-0.0803) - 0.0007i);
end