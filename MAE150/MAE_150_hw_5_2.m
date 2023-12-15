clear all
close all
clc

E = 200*10^9; %Pa
I1 = (0.1^4)/12; %kg*m^2
I2 = pi*(0.03^4)/4; %kg*m^2
I3 = pi*(0.015^4)/4; %kg*m^2

fprintf(" part a \n")
fprintf("I1 = " + I1 + "kg*m^2\n")
fprintf("I2 = " + I2 + "kg*m^2\n")
fprintf("I3 = " + I3 + "kg*m^2\n")

Le = 5/4; %m %element length

Ke = cell(1,16); %cell array of element stiffness matrices

for i = 1:4
    Ke{i} = [12*E*I1/(Le^3) 6*E*I1/(Le^2) -12*E*I1/(Le^3) 6*E*I1/(Le^2);
    6*E*I1/(Le^2) 4*E*I1/Le -6*E*I1/(Le^2) 2*E*I1/Le;
    -12*E*I1/(Le^3) -6*E*I1/(Le^2) 12*E*I1/(Le^3) -6*E*I1/(Le^2);
    6*E*I1/(Le^2) 2*E*I1/Le -6*E*I1/(Le^2) 4*E*I1/Le];
end
for i = 5:12
    Ke{i} = [12*E*I2/(Le^3) 6*E*I2/(Le^2) -12*E*I2/(Le^3) 6*E*I2/(Le^2);
    6*E*I2/(Le^2) 4*E*I2/Le -6*E*I2/(Le^2) 2*E*I2/Le;
    -12*E*I2/(Le^3) -6*E*I2/(Le^2) 12*E*I2/(Le^3) -6*E*I2/(Le^2);
    6*E*I2/(Le^2) 2*E*I2/Le -6*E*I2/(Le^2) 4*E*I2/Le];
end
for i = 13:16
    Ke{i} = [12*E*I3/(Le^3) 6*E*I3/(Le^2) -12*E*I3/(Le^3) 6*E*I3/(Le^2);
    6*E*I3/(Le^2) 4*E*I3/Le -6*E*I3/(Le^2) 2*E*I3/Le;
    -12*E*I3/(Le^3) -6*E*I3/(Le^2) 12*E*I3/(Le^3) -6*E*I3/(Le^2);
    6*E*I3/(Le^2) 2*E*I3/Le -6*E*I3/(Le^2) 4*E*I3/Le];
end

Kexpanded = cell(1,16);

for i = 1:16
    Kexpanded{i}=zeros(34);
    for j = 1:4
        for k = 1:4
            Kexpanded{i}(j+(i-1)*2,k+(i-1)*2) = Ke{i}(j,k);
        end
    end
end

KGlobal = sum(cat(34,Kexpanded{:}),34);

fprintf("\n part b \n")
fprintf("norm(KGlobal) = " + norm(KGlobal) + "\n")

%apply BCs

u1 = 0; u2 = 0;

Kreduced = zeros(32);
for i = 1:32
    for j = 1:32
        Kreduced(i,j) = KGlobal(i+2,j+2);
    end
end

fprintf("cond(Kreduced) = " + cond(Kreduced) + "\n")

Q = 30; %N/m
M = 2000; %N/m
Rreduced = zeros(32,1);
for i = 5:13
    Rreduced((i*2)-1) = -Q*Le/2;
end
Rreduced(25) = Rreduced(25) + 100;
Rreduced(10) = -Q*(10^2)/12;
Rreduced(26) = Q*(10^2)/12;
Rreduced(end) = M;

disp_reduced = (Kreduced^(-1))*Rreduced;

disp = zeros(34,1);
for i = 1:32
    disp(i+2) = disp_reduced(i);
end

fprintf("\n part c")
disp = disp

R = zeros(34,1);
for i = 1:34
    R(i) = dot(KGlobal(i,:),disp);
end

X = linspace(0,20,17);
Y1 = zeros(1,17);
Y2 = zeros(1,17);
for i = 1:17
    Y2(i) = rad2deg(-disp(2*i));
    Y1(i) = -disp((2*i)-1);
end
plot(X,Y1)
xlabel("x")
ylabel("vertical deflection (m)")
figure
plot(X,Y2)
xlabel("x")
ylabel("rotation angle (deg)")

fprintf("\n part f \n")
fprintf("Reaction force = " + R(1) + "N\n")
fprintf("Reaction moment = " + R(2) + "Nm\n")
fprintf("not sure what is wrong with my code but through hand calculations, the answer should be 200N and -500Nm")
