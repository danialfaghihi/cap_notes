%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Script for calibrating inadequecy ODE
%%% against HF data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
set(0,'DefaultFigureWindowStyle','docked')


%% Loading HF data
A = csvread('../hf_lf_models/error_in_qoi_sin.txt');
tau       = A(:,1);
I         = A(:,2);
eps_exact = A(:,3); 

Nt = size(tau,1);

plot(I)


%% optmization
fun = @(x)inadq(x,tau',eps_exact',I, Nt);

x0 = [13 13  0.55];
bestx = fminsearch(fun,x0)


c_b = bestx(1);
lambda_mean_b = bestx(2);
alpha_b = bestx(3);

Epsilonfit(1) = 0.0;
lambdafit(1) = 20.0;
dtau = tau(2) - tau(1);


for i = 1 : Nt-1
    
    lambdafit(i+1) = lambdafit(i) - c_b*(lambdafit(i)-lambda_mean_b)*dtau;
    Epsilonfit(i+1) = Epsilonfit(i) - (lambdafit(i)*Epsilonfit(i)*dtau) ...
        + alpha_b*(I(i+1)-I(i));

end

plot(tau,eps_exact,'b','LineWidth',3);
hold on
plot(tau,-Epsilonfit,'--r','LineWidth',3);
xlabel('\tau'); ylabel('\epsilon');
legend('HF data','fitted ODE')
axis square
prop_plots