clear all
close all
clc

l2 = 6;
l3 = 12;
l4 = 15;
om2 = 100

%preallocate
th2 = [0:1:360]*pi/180;
th3a = zeros(1,length(th2));
th4a = zeros(1,length(th2));
xp = zeros(1,length(th2));
yp = zeros(1,length(th2));
xq = zeros(1,length(th2));
yq = zeros(1,length(th2));
om4 = zeros(1,length(th2));

for i = 1:length(th2)

    %initial guess
    th3 = (-45*pi)/180;
    th4 = (105*pi)/180;

    f1 = @(th3,th4) -18 + l2*cos(th2(i)) + l3*cos(th3) - l4*cos(th4)
    f2 = @(th3,th4) 5 + l2*sin(th2(i)) - l3*sin(th3) - l4*sin(th4)

    h=1;
    k=1;

    while abs(h) > 0.001 || abs(k) > 0.001
       
        r1 = -f1(th3,th4);
        r2 = -f2(th3,th4);

        A = l3*l4*sin(th3)*cos(th4)+l3*l4*cos(th3)*sin(th4);
        h = -l4/A*(r1*cos(th4)+r2*sin(th4));
        k = -l3/A*(r2*sin(th3)-r1*cos(th3));

        th3 = th3 + h;
        th4 = th4 + k;
    end

    th3a(i) = th3;
    th4a(i) = th4;

    xp(i) = l2*cos(th2(i))+5*cos(th3-pi/2);
    yp(i) = l2*sin(th2(i))-5*sin(th3-pi/2);

    xq(i) = 18+22*cos(th4);
    yq(i) = -5+22*sin(th4);

    om4(i) = om2*l2*sin(-th3-th2(i))/(l4*sin(-th3-th4));
end

dp = sqrt((diff(xp).^2)+(diff(yp).^2))
dp(361) = dp(end)
dt = om2/360

plot(rad2deg(th2),rad2deg(th4a),'b','LineWidth',2)
title("part a")
xlabel("\theta_2 (deg)")
ylabel("\theta_4 (deg)")
figure
plot(xp,yp,'b','LineWidth',2)
title("part b")
xlabel("x position (cm)")
ylabel("y position (cm)")
hold on
plot(0,0,'rx','LineWidth',2)
legend("path of P","origin")
figure
plot(rad2deg(th2),sqrt( ((xp-xq).^2) + ((yp-yq).^2) ),'b','LineWidth',2)
title("part c")
xlabel("\theta_2 (deg)")
ylabel("distance between P and Q (cm)")
figure
plot(rad2deg(th4a),om4,'b','LineWidth',2)
title("part d")
xlabel("\theta_4 (deg)")
ylabel("angular velocity (rad/s)")
figure
plot(rad2deg(th2),dp/dt,'b','LineWidth',2)
title("part e")
xlabel("\theta_2 (deg)")
ylabel("velocity of P (cm/s)")



