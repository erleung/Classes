clear all
close all
clc

AH = zeros(1,1000000);
AD = zeros(1,1000000);
BH = zeros(1,1000000);
BD = zeros(1,1000000);
CH = zeros(1,1000000);
CD = zeros(1,1000000);
r = rand(2,1000000);
rn = randn(2,1000000);

for i = 1:1000000
    AH(i) = 20*r(1,i)+55;
    BH(i) = 3*rn(1,i)+97;
   
    AD(i) = 10*r(2,i)+90;
    BD(i) = 0.5*rn(2,i)+95;

    CH(i) = 0.25*((sqrt(AH(i))+sqrt(BH(i)))^2);
    CD(i) = 0.25*((sqrt(AD(i))+sqrt(BD(i)))^2);
    
end

subplot(3,1,1)
h = histogram(AH,(50:110));
h.Normalization = 'probability';
hold on
h = histogram(AD,(50:110));
h.Normalization = 'probability';
legend('Hedgie','Doge')

subplot(3,1,2)
h = histogram(BH,(50:110));
h.Normalization = 'probability';
hold on
h = histogram(BD,(50:110));
h.Normalization = 'probability';
legend('Hedgie','Doge')

subplot(3,1,3)
h = histogram(CH,(50:110));
h.Normalization = 'probability';
hold on
h = histogram(CD,(50:110));
h.Normalization = 'probability';
legend('Hedgie','Doge')

c = 0;
for i = 1:length(CH)
    if CH(i)<84
        c = c+1;
    end
end
disp("Hedgie's chances of failing in Scenario C = " + c/1000000)
disp("Doge std for scenario B = " + std(BD))
disp("Doge std for scenario C = " + std(CD))
