clear all
close all
clc

%test
syms z1 p1
z1 = 1
p1 = 10
Ds = RR_tf([1 z1],[1 p1 0])
Dsm = tf([1 1],[1 10 0])

disp("Eric's C2D_matched:")
EL_C2D_matched(Ds,0.01,0.001)
disp("MATLAB's C2D_matched:")
c2d(Dsm,0.01,'matched')

function [Dz]= EL_C2D_matched(Ds,h,omega_bar)
    
    %map poles from s to z
    rd=RR_roots(Ds.den);
    for j=1:length(rd)
        z(j) = exp(rd(j)*h);
    end

    %map zeros from s to z
    rn=RR_roots(Ds.num);
    if ~isempty(rn)
        for j=1:length(rn)
            n(j) = exp(rn(j)*h);
        end
    else
        n=[];
    end

    %map infinite zeros
    if length(rd)>length(n)+1
        for j = length(n)+1:length(z)-1
            n(j) = -1;
        end
    end

    Dz = RR_tf(n,z,1);

    %match gain
    if nargin==2
        if RR_evaluate(Ds.den,0) == 0
            disp("error: omega_bar just be nonzero!")
            Dz = NaN;
            return
        else, DC_gain = RR_evaluate(Ds,0);
            K = DC_gain/(RR_evaluate(Dz.num,1)/RR_evaluate(Dz.den,1));
        end
    else, DC_gain = RR_evaluate(Ds,1i*omega_bar); 
        disp("omega_bar = " +omega_bar)
        g = exp(h*1i*omega_bar);
        K = DC_gain/(RR_evaluate(Dz.num,g)/RR_evaluate(Dz.den,g));
        disp("g = " + g)
    end
    Dz = RR_tf(n,z,K);
end


