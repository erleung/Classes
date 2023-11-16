clear all
close all
clc

r1 = [1.81065659; 1.06066883; 0.31065150];
r2 = [1.41422511; 0; 1.41420200];
r3 = [1.35353995; 1.41422511; -0.64644950];

%part a
fprintf("part a \n")
fprintf("dot(r1,cross(r2,r3)) = " + dot(r1,cross(r2,r3)))
fprintf("\nr vectors are coplanar!\n")

%part b
fprintf("\npart b \n")
D = cross(r2,r3)+cross(r3,r1)+cross(r1,r2);
N = norm(r1)*cross(r2,r3) + norm(r2)*cross(r3,r1) + norm(r3)*cross(r1,r2);
S = (norm(r2)-norm(r3))*r1 + (norm(r3)-norm(r1))*r2 + (norm(r1)-norm(r2))*r3;

v1 = (1/norm(r1))*sqrt(1/(norm(N)*norm(D)))*cross(D,r1) + sqrt(1/(norm(N)*norm(D)))*S
fprintf("v1 units: km/s")

%part c 
fprintf("\n\npart c \n")
p = norm(N)/norm(D)
fprintf("units for p: km \n")
e = norm(S)/norm(D)
a = p/(1-e^2);
h = cross(r1,v1);
K = [0;0;1];
i = acosd(dot(K,h)/norm(h))
fprintf("units for i: deg \n")
n = cross(K,h);
e = (norm(v1)^2-1/norm(r1))*r1 - dot(r1,v1)*v1;
uppercase_omega = acosd(n(1)/norm(n))
fprintf("units for uppercase_omega: deg \n")
lowercase_omega = acosd(dot(n,e)/(norm(n)*norm(e)));
lowercase_omega = 360 - lowercase_omega
fprintf("units for lowercase_omega: deg \n")
nu = acosd(dot(e,r1)/(norm(e)*norm(r1)));
nu = 360-nu
fprintf("units for nu: deg \n")

%part d
fprintf("\n\npart d \n")
fprintf("i = " + i + " > 90deg --> Retrograde!")

%part e
fprintf("\n\npart e \n")
fprintf("The orbit is elliptical. The object has just passed apoapsis at r1")