% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw3_amongUs.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1.

% Define simulation parameters
ITERATIONS = 1e6;  % Number of simulations
CREWMATES = 6;  % Number of crewmates
ROUNDS = 12;  % Number of rounds

CREWMATE_SIDES = 4;  % Sides on the crewmates' resistance die
IMPOSTER_ROLLS = 2;  % Number of rolls for the imposter's sus ability
IMPOSTER_SIDES = 2;  % Sides on the imposter's sus ability die

rng(0x73757300);  % Set seed for deterministic results  

%% 2.

% Generate random values for crewmates' sus resistance, imposter's sus ability, and targets
crewmates = randi(CREWMATE_SIDES, CREWMATES, ITERATIONS);  % Sus resistance for crewmates
sus = randi(IMPOSTER_SIDES, IMPOSTER_ROLLS, ITERATIONS);   % Imposter's sus ability
sus = sum(sus);  % Sum the two rolls for the imposter's sus ability

targets = randi(CREWMATES, ROUNDS, ITERATIONS);  % Random targets for the imposter

%% 3.

% Initialize a matrix for kills (0 = alive, 1 = dead)
kills = zeros(size(crewmates));

% Convert target rows and columns to linear indices
rows = targets(:);  % Crewmates targeted
cols = repmat(1:ITERATIONS, ROUNDS, 1);  % Iteration indices
cols = cols(:);  % Flatten into a single column

% Get the linear indices for kills
ind = sub2ind(size(kills), rows, cols);

kills(ind) = 1;

%% 4.

% Determine which crewmates survive
survivors = ~((sus > crewmates) & kills);  % Survivors are those who aren't killed and have resistance > sus ability

% Check if a loss occurs (1 or fewer survivors)
losses = sum(survivors) <= 1;  % Sum survivors and check if less than or equal to 1

loss_rate = mean(losses);  % Calculates the average loss rate



