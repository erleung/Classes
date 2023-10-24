clear all
close all
clc

u1 = zeros(1,1000);
u2 = zeros(1,1000);
for n = 1:1000
    for i = 1:n
        x = rand;
        u1(n) = u1(n)+x^2;
        u2(n) = u2(n)+cos(pi*x);
    end
    u1(n)=u1(n)/n;
    u2(n)=u2(n)/n;
end

subplot(2,1,1)
plot(u1)
hold on
yline(1/3)
legend("estimate","true value")
xlabel("n")
subplot(2,1,2)
plot(u2)
yline(0)
legend("estimate","true value")
xlabel("n")


