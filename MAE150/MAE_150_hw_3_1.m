clear all
close all
clc

syms theta 

omega = 500*360/60;
f1 = 5*(1-cos(pi*theta/60));
f2 = 10 + 15*(((theta-80)/70)-sin(2*pi*(theta-80)/70)/(2*pi));
f3 = 25 - 25*(10*(theta-200)^3/100^3-15*(theta-200)^4/100^4+6*(theta-200)^5/100^5);

subplot(4,1,1)
hold on
fplot(f1, [0 60],'b','LineWidth',2)
fplot(10, [60 80],'b','LineWidth',2)
fplot(f2, [80 150],'b','LineWidth',2)
fplot(25, [150 200],'b','LineWidth',2)
fplot(f3, [200 300],'b','LineWidth',2)
fplot(0, [300 360],'b','LineWidth',2)
xlabel("\theta (deg)")
ylabel("displacement (mm)")

subplot(4,1,2)
hold on
fplot(diff(f1)*omega, [0 60],'r','LineWidth',2)
fplot(0, [60 80],'r','LineWidth',2)
fplot(diff(f2)*omega, [80 150],'r','LineWidth',2)
fplot(0, [150 200],'r','LineWidth',2)
fplot(diff(f3)*omega, [200 300],'r','LineWidth',2)
fplot(0, [300 360],'r','LineWidth',2)
xlabel("\theta (deg)")
ylabel("velocity (mm/s)")

subplot(4,1,3)
hold on
fplot(diff(f1,2)*omega^2, [0 60],'g','LineWidth',2)
fplot(0, [60 80],'g','LineWidth',2)
fplot(diff(f2,2)*omega^2, [80 150],'g','LineWidth',2)
fplot(0, [150 200],'g','LineWidth',2)
fplot(diff(f3,2)*omega^2, [200 300],'g','LineWidth',2)
fplot(0, [300 360],'g','LineWidth',2)
xlabel("\theta (deg)")
ylabel("acceleration (mm/s^{2})")

subplot(4,1,4)
hold on
fplot(diff(f1,3)*omega^3, [0 60],'m','LineWidth',2)
fplot(0, [60 80],'m','LineWidth',2)
fplot(diff(f2,3)*omega^3, [80 150],'m','LineWidth',2)
fplot(0, [150 200],'m','LineWidth',2)
fplot(diff(f3,3)*omega^3, [200 300],'m','LineWidth',2)
fplot(0, [300 360],'m','LineWidth',2)
xlabel("\theta (deg)")
ylabel("jerk (mm/s^{3})")

%%

pressureang1 = atand(diff(f1)/(35+f1));
pressureang2 = atand(diff(f2)/(35+f2));
pressureang3 = atand(diff(f3)/(35+f3));

figure
hold on
fplot(pressureang1, [0,60],'b','LineWidth',2)
fplot(0, [60,80],'b','LineWidth',2)
fplot(pressureang2, [80,150],'b','LineWidth',2)
fplot(0, [150,200],'b','LineWidth',2)
fplot(pressureang3, [200,300],'b','LineWidth',2)
fplot(0, [300,360],'b','LineWidth',2)
xlabel("\theta (deg)")
ylabel("pressure angle (deg)")
subtitle("good cam design!")

%%
figure
% 
disctheta = linspace(0,360,361);
discf1 = double(subs(f1,theta,disctheta(1:61)));
discf2 = double(subs(f2,theta,disctheta(81:151)));
discf3 = double(subs(f3,theta,disctheta(201:301)));

polarplot(deg2rad(disctheta(1:61)),30.+discf1,'b','LineWidth',2)
hold on
polarplot(deg2rad(disctheta(1:61)),35.+discf1,'r--','LineWidth',2)
polarplot(deg2rad(disctheta),35.+zeros(1,361),'g--','LineWidth',2)
polarplot(deg2rad(disctheta),30.+zeros(1,361),'m','LineWidth',2)


polarplot(deg2rad(disctheta(61:81)),30.+10*ones(1,21),'b','LineWidth',2)
polarplot(deg2rad(disctheta(81:151)),30.+discf2,'b','LineWidth',2)
polarplot(deg2rad(disctheta(151:201)),30.+25*ones(1,51),'b','LineWidth',2)
polarplot(deg2rad(disctheta(201:301)),30.+discf3,'b','LineWidth',2)
polarplot(deg2rad(disctheta(301:361)),30.+zeros(1,61),'b','LineWidth',2)


polarplot(deg2rad(disctheta(61:81)),35.+10*ones(1,21),'r--','LineWidth',2)
polarplot(deg2rad(disctheta(81:151)),35.+discf2,'r--','LineWidth',2)
polarplot(deg2rad(disctheta(151:201)),35.+25*ones(1,51),'r--','LineWidth',2)
polarplot(deg2rad(disctheta(201:301)),35.+discf3,'r--','LineWidth',2)
polarplot(deg2rad(disctheta(301:361)),35.+zeros(1,61),'r--','LineWidth',2)


legend('contour','pitch curve','prime circle','base circle')
subtitle('r [mm]')

%%

figure
hold on
[x,y] = (pol2cart(deg2rad(disctheta(1:61)),30.+discf1));
[x(61:81),y(61:81)] = pol2cart(deg2rad(disctheta(61:81)),30.+10*ones(1,21));
[x(81:151),y(81:151)] = pol2cart(deg2rad(disctheta(81:151)),30.+discf2);
[x(151:201),y(151:201)] = pol2cart(deg2rad(disctheta(151:201)),30.+25*ones(1,51));
[x(201:301),y(201:301)] = pol2cart(deg2rad(disctheta(201:301)),30.+discf3);
[x(301:361),y(301:361)] = pol2cart(deg2rad(disctheta(301:361)),30.+zeros(1,61));
[xc,yc] = pol2cart(deg2rad(disctheta(1:361)),35);

text(1,1,'follower is vertical')

for i = 1:10
    subplot(2,5,i)
    hold on
    XX = [x;y;ones(1,length(x))];
    XXX = [cosd(-30*(i-1)-90) sind(-30*(i-1)-90) 0; -sind(-30*(i-1)-90) cosd(-30*(i-1)-90) 0; 0 0 1]*XX;
    plot(XXX(1,:),XXX(2,:),'b','LineWidth',2)
    plot(xc,yc,'r-.','LineWidth',2)
    axis equal
    xlim([-70 70])
    ylim([-70 70])
    title("\theta = " + (i-1)*30 + "degs")
end




