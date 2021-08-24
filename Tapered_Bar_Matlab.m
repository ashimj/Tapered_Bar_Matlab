clear all
clc
% Tapering steel
E = 200E9; % Pa
A0 = (pi/4)*(50E-3)^2; % m^2
At = (pi/4)*(20E-3)^2; % m^2
L = 0.1; % m
N = 30; % Number of elements
% Compute element length, area, k
Le = L/N;
for i = 1:N,
Atop = A0-(A0-At)/N*(i-1);
Abot = A0-(A0-At)/N*i;
A(i) = (Atop+Abot)/2;
k(i) = A(i)*E/Le;
end
% Assembly of the stiffness matrix using k's.
K = zeros(N,N);
K(1,1) = k(1) + k(2);
K(1,2) = -k(2);
for i = 2:N-1,
K(i,i-1) = -k(i);
K(i,i) = k(i) + k(i+1);
K(i,i+1) = -k(i+1);
end
K(N,N-1) = -k(N);
K(N,N) = k(N);
% defining force {F}. It is a column vector.
F = zeros(N,1);
F(N) = 300;
% Solve for displacements {q}. It is a column vector.
q =(inv(K)*F)*1000;
% Solve stresses {sigma}. It is a column vector.
valueSigma = zeros(N:N);
for i = N:-1:2,
sigma=(q(i)-q(i-1))*E/(Le*1000);
valueSigma(i) = sigma; %Pa
display(sigma);
end
