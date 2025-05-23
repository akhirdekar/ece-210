% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw1_rollingInTheMud.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

%% 1.

u = [11, 13, 17];
v = [-1; -1; -1];
A = [-u; 2 .* u; 7 .* u];
B = [A.', v];

%% 2.

c = exp(1j * pi / 4);
d = sqrt(1j);
l = floor(nthroot(8.4108e6, 2.1));
k = floor(100 * log(2)) + ceil(exp(7.5857));

%% 3.

A = [1 -11 -3;
     1  1   0;
     2  5   1];  % Equivalently, 'A = [1, -11, -3; 1, 1, 0; 2, 5, 1]'

b = [-37; -1; 10];

x = A \ b;

disp('Solution vector x:');
disp(x);
