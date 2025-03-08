% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw4_funcOff.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1.

ip = @(u, v) u' * v;             % Inner product for complex vectors
ip_norm = @(v) sqrt(ip(v, v));   % Norm derived from the inner product

%% 2.

S = [
    1,         2 + 3j,    -1 + 7j;
    1j,        3j,        6 + 10j;
    2 - 1j,    1 - 1j,    11 - 4j;
    -1,        2j,        3 + 4j
];

%% 3.

U = gram_schmidt(S, ip, ip_norm);

%% 4.

numCols = size(U, 2);
areAllOrthogonal = true;

for col1 = 1:numCols
    for col2 = col1+1:numCols
        if ~isorthogonal(U(:, col1), U(:, col2), ip)
            areAllOrthogonal = false;
            break;
        end
    end
    if ~areAllOrthogonal
        break;
    end
end

% Display the result
if areAllOrthogonal
    disp('All columns in U are mutually orthogonal.');
else
    disp('Some columns in U are not orthogonal.');
end

% Equivalently, you can check each column for norm 1 using: 
% normsCheck = arrayfun(@(c) ip_norm(U(:,c)), 1:numCols);
% disp(normsCheck);

%%  Functions

function U = gram_schmidt(V, ip_fn, norm_fn)
    % Performs the Gram-Schmidt process on the columns of V
    % using the given inner product (ip_fn) and norm (norm_fn).
   
    % Input:
    %   V      - matrix whose columns are the vectors to be orthonormalized
    %   ip_fn  - function handle for the inner product
    %   norm_fn- function handle for the norm derived from the inner product
  
    % Output:
    %   U      - matrix with orthonormal columns

    [n, k] = size(V);     % n = dimension, k = number of vectors
    U = zeros(n, k);      % initialize output matrix

    U(:, 1) = V(:, 1) / norm_fn(V(:, 1));

    % For subsequent vectors, subtract projections onto previous columns
    for i = 2:k
        tempVec = V(:, i);

        for j = 1:(i - 1)
            tempVec = tempVec - ip_fn(U(:, j), tempVec) * U(:, j);
        end

        % Normalize and store in U
        U(:, i) = tempVec / norm_fn(tempVec);
    end
end

function isOrtho = isorthogonal(u, v, ip_fn)
    % isorthogonal
    % Checks if two vectors u and v are orthogonal based on
    % the provided inner product function ip_fn.
 
    % Input:
    %   u, v   - vectors to be checked
    %   ip_fn  - function handle for the inner product
  
    % Output:
    %   isOrtho- returns true if ip_fn(u, v) is close to zero

    tolerance = eps;  % a small threshold
    isOrtho = abs(ip_fn(u, v)) < tolerance; % The vectors are considered orthogonal
end
