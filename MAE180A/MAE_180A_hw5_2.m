clear all
close all
clc

%part a
fprintf("'part a")
magp = 0.8;
magdp = 0.07;
Az = 65;
dAz = 1.8;
E1 = 40;
dE1 = 2.5;

rho = magp*[-cosd(E1)*cosd(Az) ; cosd(E1)*sind(Az) ; sind(E1)]
fprintf("units for rho: DU")

dps = -magdp*cosd(E1)*cosd(Az) + magp*dE1*sind(E1)*cosd(Az) + magp*dAz*cosd(E1)*sind(Az);
dpe = magdp*cosd(E1)*sind(Az) - magp*dE1*sind(E1)*sind(Az) + magp*dAz*cosd(E1)*cosd(Az);
dpz = magdp*sind(E1) + magp*dE1*cosd(E1);
rho_dot = [dps; dpe; dpz]
fprintf("units for rho_dot: DU/TU")

%part b
r = rho + [0;0;1]
fprintf("units for r: DU")

