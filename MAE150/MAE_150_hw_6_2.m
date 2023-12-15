clear all 
close all
clc

EI = 10^(-3);
Le = 2.5;

Ke = cell(1,4);
M = cell(1,4);
m = 1000/4;

for i = 1:4
    Ke{i} = [12*EI/(Le^3) 6*EI/(Le^2) -12*EI/(Le^3) 6*EI/(Le^2);
    6*EI/(Le^2) 4*EI/Le -6*EI/(Le^2) 2*EI/Le;
    -12*EI/(Le^3) -6*EI/(Le^2) 12*EI/(Le^3) -6*EI/(Le^2);
    6*EI/(Le^2) 2*EI/Le -6*EI/(Le^2) 4*EI/Le];
    M{i} = m/2*[1 0 0 0; 0 (Le^2)/12 0 0; 0 0 1 0; 0 0 0 (Le^2)/12];
end

Kexpanded = cell(1,4);
Mexpanded = cell(1,4);

for i = 1:4
    Kexpanded{i}=zeros(10);
    Mexpanded{i}=zeros(10);
    for j = 1:4
        for k = 1:4
            Kexpanded{i}(j+(i-1)*2,k+(i-1)*2) = Ke{i}(j,k);
            Mexpanded{i}(j+(i-1)*2,k+(i-1)*2) = M{i}(j,k);
        end
    end
end

KGlobal = sum(cat(10,Kexpanded{:}),10);
MGlobal = sum(cat(10,Mexpanded{:}),10);

[x,omegasquared] = eig((MGlobal^-1)*KGlobal)

