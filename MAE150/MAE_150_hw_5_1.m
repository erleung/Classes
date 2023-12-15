clc
clear all
close all

E = 210*10^9; %Pa
A = 0.00195; %m^2

%lengths in m
L1 = 4; L2 = 2; L3 = 5; L4 = 6; L5 = 5;

%beta values in degs
B1 = 90; %i = 1, j = 2
B2 = 180; %i = 2, j = 3
B3 = 180+53.13010235; %i = 3, j = 4
B4 = 180; %i = 1, j = 4
B5 = 126.8698976; %  i = 1, j =3

c1 = cosd(B1); s1 = sind(B1);
c2 = cosd(B2); s2 = sind(B2);
c3 = cosd(B3); s3 = sind(B3);
c4 = cosd(B4); s4 = sind(B4);
c5 = cosd(B5); s5 = sind(B5);

k1 = E*A/L1; k2 = E*A/L2; k3 = E*A/L3; k4 = E*A/L4; k5 = E*A/L5; 

Sel1 = k1*[c1^2 c1*s1 -(c1^2) -c1*s1;
    c1*s1 s1^2 -c1*s1 -(s1^2);
    -(c1^2) -c1*s1 c1^2 c1*s1;
    -c1*s1 -(s1^2) c1*s1 s1^2];

Sel2 = k2*[c2^2 c2*s2 -(c2^2) -c2*s2;
    c2*s2 s2^2 -c2*s2 -(s2^2);
    -(c2^2) -c2*s2 c2^2 c2*s2;
    -c2*s2 -(s2^2) c2*s2 s2^2];

Sel3 = k3*[c3^2 c3*s3 -(c3^2) -c3*s3;
    c3*s3 s3^2 -c3*s3 -(s3^2);
    -(c3^2) -c3*s3 c3^2 c3*s3;
    -c3*s3 -(s3^2) c3*s3 s3^2];

Sel4 = k4*[c4^2 c4*s4 -(c4^2) -c4*s4;
    c4*s4 s4^2 -c4*s4 -(s4^2);
    -(c4^2) -c4*s4 c4^2 c4*s4;
    -c4*s4 -(s4^2) c4*s4 s4^2];

Sel5 = k5*[c5^2 c5*s5 -(c5^2) -c5*s5;
    c5*s5 s5^2 -c5*s5 -(s5^2);
    -(c5^2) -c5*s5 c5^2 c5*s5;
    -c5*s5 -(s5^2) c5*s5 s5^2];

N = 8;

KGlobal = zeros(N,N);
A = zeros(N,N); B = zeros(N,N); C = zeros(N,N); D = zeros(N,N); E = zeros(N,N); 

for i = 1:4
    for j = 1:4
        A(i,j) = Sel1(i,j);
    end
end

for i = 1:4
    for j = 1:4
        B(i+2,j+2) = Sel2(i,j);
    end
end

for i = 1:4
    for j = 1:4
        C(i+4,j+4) = Sel3(i,j);
    end
end

for i = 1:2
    for j = 1:2
        D(i,j) = Sel4(i,j);
    end
    for j = 3:4
        D(i,j+4) = Sel4(i,j);
    end
end
for i = 3:4
    for j = 1:2
        D(i+4,j) = Sel4(i,j);
    end
    for j = 3:4
        D(i+4,j+4) = Sel4(i,j);
    end
end

for i = 1:2
    for j = 1:2
        E(i,j) = Sel5(i,j);
    end
    for j = 3:4
        E(i,j+2) = Sel5(i,j);
    end
end
for i = 3:4
    for j = 1:2
        E(i+2,j) = Sel5(i,j);
    end
    for j = 3:4
        E(i+2,j+2) = Sel5(i,j);
    end
end

KGlobal = KGlobal+A+B+C+D+E;

%apply BC:
u2 = 0; v2=0; v4=0;

Kreduced = zeros(5,5);
for i = 1:2
    for j = 1:2
        Kreduced(i,j) = KGlobal(i,j);
    end
    for j = 3:5
        Kreduced(i,j) = KGlobal(i,j+2);
    end
end
for i = 3:5
    for j = 1:2
        Kreduced(i,j) = KGlobal(i+2,j);
    end
    for j = 3:5
        Kreduced(i,j) = KGlobal(i+2,j+2);
    end
end

Freduced = 1000*[40; 0; 0; -100; 0];

disp_reduced = (Kreduced^(-1))*Freduced;

u1 = disp_reduced(1); v1 = disp_reduced(2); 
u3 = disp_reduced(3); v3 = disp_reduced(4);
u4 = disp_reduced(5);

disp = [u1;v1;u2;v2;u3;v3;u4;v4];

Fr = zeros(8,1);
for i = 1:8
    Fr(i) = dot(KGlobal(i,:),disp);
end

X = [0 6 6 3 6 3 0];
Y = [0 0 4 4 0 4 0];
plot(X,Y,"black",'LineWidth',2)
hold on
axis equal
xlim('padded')

X = [0+u4*200 6+u1*200 6+u2*200 3+u3*200 6+u1*200 3+u3*200 0+u4*200];
Y = [0+v4*200 0+v1*200 4+v2*200 4+v3*200 0+v1*200 4+v3*200 0+v4*200];
plot(X,Y,"r--",'LineWidth',2)

legend("original", "after displacement")

fprintf(" part a \n")
fprintf("element 1 stiffness matrix trace: " + trace(Sel1) + "\n")
fprintf("element 2 stiffness matrix trace: " + trace(Sel2) + "\n")
fprintf("element 3 stiffness matrix trace: " + trace(Sel3) + "\n")
fprintf("element 4 stiffness matrix trace: " + trace(Sel4) + "\n")
fprintf("element 5 stiffness matrix trace: " + trace(Sel5) + "\n")
fprintf("Global stiffness matrix trace: " + trace(KGlobal) + "\n")

fprintf("\n part b \n")
fprintf("node 1 reaction forces: " + "x:" + u1 + " y:" + v1+ "\n")
fprintf("node 2 reaction forces: " + "x:" + u2 + " y:" + v2 + "\n")
fprintf("node 3 reaction forces: " + "x:" + u3 + " y:" + v3 + "\n")   
fprintf("node 4 reaction forces: " + "x:" + u4 + " y:" + v4 + "\n")    
