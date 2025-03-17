% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw8_mustBeEasy.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1. 

% BJT Equation
syms I_C V_BE V_T A_E q D_n n_i N_B W_B
bjtEqn = I_C == (A_E * q * D_n * n_i^2 / (N_B * W_B)) * exp(V_BE / V_T);
A_E_sol = solve(bjtEqn, A_E);

disp('A_E in terms of I_C:');
disp(A_E_sol);

%% 2.

syms R C V_S(t) V_C(t)
ode = R*C*diff(V_C(t), t) + V_C(t) - V_S(t) == 0;
V_C_sol = dsolve(ode);   

disp('Solution for V_C(t):');
disp(V_C_sol);

%% 3.

mu_0_sym = 4 * sym('pi') * 1e-7;
mu_0_1000dp = vpa(mu_0_sym, 1000);

disp('mu_0 to 1000 decimals:');
disp(mu_0_1000dp);
