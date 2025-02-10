% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw2_aNewWayOfThinking.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1.

u = -4: 2: 4;
v = linspace(0, pi, 5);  % Creates 5 equally spaced points between 0 and pi. Equivalently, 'v = 0: pi/4: pi'

%% 2.

f = prod(10:-1:1);  % Equivalently, 'f = prod(1:10)'

%% 3.

A = zeros(2, 4);  % Creates a 2x4 matrix of only zeros. 'A = [0 0 0 0; 0 0 0 0]'
A(1, 1) = 1;      % Sets the element at (1, 1) to 1
A(2, 3) = 1;      % Set the element at (2, 3) to 1

B = [1:2:15, 2:2:16];
B = reshape(B, 4, 4);

%% 4.

i = 50;
a_n = (2 .* (0:i) + 1)';
t = linspace(-pi, pi, 1000);      % Creates 1000 evenly spaced points for t
s = sum(sin(a_n * t) ./ a_n, 1);  % Computes the sum of sine waves for each t

plot(t, s);




