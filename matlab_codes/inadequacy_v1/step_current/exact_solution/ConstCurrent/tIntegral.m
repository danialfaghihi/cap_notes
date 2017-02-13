%% Inverse Laplace transform

function V = tIntegral(tau)
kappa = 0.0195174;   %--- sec/m
sigma = 52.1;   %--- sec/m

L = 50e-6;  %--- m
C = 0.03134;  %--- F/m2

V0 = 1.25;   %--- volt
Iunscaled = 200;   %--- Amp/m^2

Iamp = (Iunscaled*(L/V0)*((kappa+sigma)/(sigma*kappa)));    %amplitude of current
fun = @(t,tau) Iamp*k(t,tau);           
V = integral(@(t)fun(t,tau),0,tau);     %time integration
end