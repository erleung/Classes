close all
clear all
clc

a = 0.1;
b = 0.1;
d = 6;

%%
% q1

s = tf('s');
G = b/(s+a) * (1 - (d/2)*s + ((d^2)/12)*s^2) / (1 + (d/2)*s + ((d^2)/12)*s^2);
bode(G)

%%
% q2
figure
rlocus(G)

%from rlocus(G) --> Ku=3.33 omega_u=0.317 at imaginary axis
Ku = 3.33;
omega_u = 0.317;
Tu = 1/omega_u;

alpha = 0.6;
Kp = alpha*Ku;

figure
margin(Kp*G)
fprintf("GM = 4.43dB \n")

%%
%q3
fprintf("\nDialing Beta does from inf introduces the integral term which bumps up gain before \n" + ...
    "omega_I = 1/T_I where T_I is proportional to beta. \n" + ...
    "This improves tracking at low frequencies when omega_I is up to an order of magnitude below the crossover frequency. \n")
fprintf("\nDialing Gamma up from 0 introduces the derivative term which bumps up phase after \n" + ...
    "omega_D = 1/T_D where T_D is proportional to gamma. \n" + ...
    "This can improve our PM and reduce overshoot if omega_D is near the crossover frequency")

%%
%q4

%4a
beta = 0.5;
gamma = 0.125;
alpha = 0.6;

Kp = alpha*Ku;
TI = beta*Tu;
TD = gamma*Tu;

fprintf("\nKp = " + Kp +"\n" + ...
    "omega_I = " + 1/TI + "\n" + ...
    "omega_D = " + 1/TD);

D = Kp*(1 + 1/(TI*s) + (TD*s));

figure
margin(D*G)

%4b

%doesnt work b/c unstable
t = 0:0.1:5*3600;
u = zeros(1,36000*5+1);
u(1:36001) = 35;
u(36002:4*36000+1) = 45;
u(4*36000+2:end) = 20;  

figure
lsim(G*Kp,u,t)

%%
h=2;
H = c2d(1/((s+1)*(s+5)),0.2,'zoh')



