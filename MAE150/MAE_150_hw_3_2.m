clear all
close all
clc

syms theta

omega = 1000*360/60;
f1 = 25*(10*(theta)^3/150^3-15*(theta)^4/150^4+6*(theta)^5/150^5);
f2 = 25 - 25*(((theta-180)/120)-sin(2*pi*(theta-180)/120)/(2*pi));

subplot(3,1,1)
hold on
fplot(f1, [0 150],'b','LineWidth',2)
fplot(25, [150 180],'b','LineWidth',2)
fplot(f2, [180 300],'b','LineWidth',2)
fplot(0, [300 360],'b','LineWidth',2)
xlabel("\theta (deg)")
ylabel("displacement (mm)") 

subplot(3,1,2)
hold on
fplot(diff(f1)*omega, [0 150],'r','LineWidth',2)
fplot(0, [150 180],'r','LineWidth',2)
fplot(diff(f2)*omega, [180 300],'r','LineWidth',2)
fplot(0, [300 360],'r','LineWidth',2)
xlabel("\theta (deg)")
ylabel("velocity (mm/s)")


subplot(3,1,3)
hold on
fplot(diff(f1,2)*omega^2, [0 150],'g','LineWidth',2)
fplot(0, [150 180],'g','LineWidth',2)
fplot(diff(f2,2)*omega^2, [180 300],'g','LineWidth',2)
fplot(0, [300 360],'g','LineWidth',2)
xlabel("\theta (deg)")
ylabel("acceleration (mm/s^{2})")

%%

pressureang1 = atand(diff(f1)/(45+f1));
pressureang2 = atand(diff(f2)/(45+f2));

figure
hold on
fplot(pressureang1, [0,150],'b','LineWidth',2)
fplot(0, [150,180],'b','LineWidth',2)
fplot(pressureang2, [180,300],'b','LineWidth',2)
fplot(0, [300,360],'b','LineWidth',2)
xlabel("\theta (deg)")
ylabel("pressure angle (deg)")

%%

disctheta = linspace(0,360,361);
discf1 = double(subs(f1,theta,disctheta(1:151)));
discf2 = double(subs(f2,theta,disctheta(181:301)));

figure
hold on
[x,y] = pol2cart(deg2rad(disctheta(1:151)),35.+discf1);
[x(151:181),y(151:181)] = pol2cart(deg2rad(disctheta(151:181)),35.+25*ones(1,31));
[x(181:301),y(181:301)] = pol2cart(deg2rad(disctheta(181:301)),35.+discf2);
[x(301:361),y(301:361)] = pol2cart(deg2rad(disctheta(301:361)),35.+zeros(1,61));

[x2,y2] = pol2cart(deg2rad(disctheta(1:151)),45.+discf1);
[x2(151:181),y2(151:181)] = pol2cart(deg2rad(disctheta(151:181)),45.+25*ones(1,31));
[x2(181:301),y2(181:301)] = pol2cart(deg2rad(disctheta(181:301)),45.+discf2);
[x2(301:361),y2(301:361)] = pol2cart(deg2rad(disctheta(301:361)),45.+zeros(1,61));

[x3(1:361),y3(1:361)] =  pol2cart(deg2rad(disctheta(1:361)),35);
[x4(1:361),y4(1:361)] =  pol2cart(deg2rad(disctheta(1:361)),45);

XX = [x;y;ones(1,length(x))];
XXX = [cosd(-90) sind(-90) 0; -sind(-90) cosd(-90) 0; 0 0 1]*XX;
plot(XXX(1,:),XXX(2,:),'b','LineWidth',2)

XXM = [x2;y2;ones(1,length(x2))];
XXXM = [cosd(-90) sind(-90) 0; -sind(-90) cosd(-90) 0; 0 0 1]*XXM;
plot(XXXM(1,:),XXXM(2,:),'r--','LineWidth',2)

plot(x3,y3,'m','LineWidth',2)
plot(x4,y4,'g--','LineWidth',2)

legend('contour','pitch curve','base circle','pitch circle')

axis equal
xlim([-70 70])
ylim([-70 70])
title("\theta = 0degs")







