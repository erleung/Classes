clear all
close all
clc

EI = 10^(-3); %GPamm
L = 10; %m
m = 1000; %kg

syms w u

K = [12*EI/(L^3) 6*EI/(L^2) -12*EI/(L^3) 6*EI/(L^2);
    6*EI/(L^2) 4*EI/L -6*EI/(L^2) 2*EI/L;
    -12*EI/(L^3) -6*EI/(L^2) 12*EI/(L^3) -6*EI/(L^2);
    6*EI/(L^2) 2*EI/L -6*EI/(L^2) 4*EI/L]

M = m/2*[1 0 0 0; 0 (L^2)/12 0 0; 0 0 1 0; 0 0 0 (L^2)/12]

eqn = vpa(det(((M^-1)*K)-((u)*eye(4))),5)
u_ans = double(solve(eqn))
A = ((M^-1)*K)-((1.92*10^-7)*eye(4))
A(:,5) = 0;
rref(A)
% A = vpa(rref(((M^-1)*K)-((1.92*10^-7)*eye(4))),5)


