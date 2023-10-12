clear all
close all
clc

b=RR_poly([-2 2 -5 5],1), a=RR_poly([-1 1 -3 3 -6 6],1), f1=RR_poly([-1 -1 -3 -3 -6 -6],1)
[x1,y1] = RR_diophantine(a,b,f1), test1=trim(a*x1+b*y1), residual1=norm(f1-test1)

disp("solution is improper y.n = 5, x.n = 3")

disp("redo with added pole at s =-20")

b=RR_poly([-2 2 -5 5],1), a=RR_poly([-1 1 -3 3 -6 6],1), f1=RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20 -20 -20 -20],1)
[x1,y1] = RR_diophantine(a,b,f1), test1=trim(a*x1+b*y1), residual1=norm(f1-test1)

disp("solution is proper y.n = 3, x.n = 4")