x = -100:100;
y = -100:100;
z = zeros(201, 201);
% v = -0.5:0.002:0.5;
% rho = 1;
L = 1;
% k = 9*10^9;
for m = 1:201
    for n = 1:201
        z(m,n) = LineElecPotential(x(n),y(m),L);
    end
end
figure;
contour3(x,y,z)
% syms x y
% ezcontour(k*rho*log(L - x + (y^2 + (L - x)^2)^(1/2)) - k*rho*log(((L + x)^2 + y^2)^(1/2) - x - L))
title('µ» ∆œﬂÕº')
grid on
hold on 
plot([-1,1], [0,0], 'r', 'LineWidth',3)
axis([-10 10 -10 10 0 3])