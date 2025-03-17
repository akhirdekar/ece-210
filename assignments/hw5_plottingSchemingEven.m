% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw5_plottingSchemingEven.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1.

% Formula:
%   a_n = 2n + 1,
%   s(t) = sum_{n=0 to i} [sin(a_n * t) / a_n], for t in [-π, π].

numTerms = 50;                     % Number of terms in the sum
nValues = 0:numTerms;              % Index set from 0 to 50
aVec = 2 * nValues + 1;            % Generate a_n = 2n + 1

tPoints = linspace(-pi, pi, 1000);  % 1000 points from -π to π
% Create a matrix of sine components, each row is sin(a_n * tPoints) / a_n

allTerms = sin(aVec.' .* tPoints) ./ aVec.';

% Sum over each row to get the approximation
squareApprox = sum(allTerms, 1);

figure('Name','Square Wave Approximation'); 
hold on;

% Plot the summed approximation, give it a legend entry
plot(tPoints, squareApprox, 'LineWidth', 1.5, 'DisplayName','Approximation');

% Plot all sine components but hide them from the legend
hAll = plot(tPoints, allTerms, 'Color',[0.6 0.6 0.6]);
set(hAll, 'HandleVisibility','off');

% Add one representative line for "Sine Components" in the legend
plot(tPoints, allTerms(1,:), 'LineWidth', 0.8, 'Color','k', ...
     'DisplayName','Sine Components');

title('Fourier Series Approximation of a Square Wave');
xlabel('t');
ylabel('Amplitude');

% Adjust the x-axis ticks to show multiples of π
xlim([tPoints(1), tPoints(end)]);
xticks([-pi, -pi/2, 0, pi/2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
ylim([-1.2, 1.2]);  % Slightly bigger range to see overshoot
grid on;
legend('Location','best');
hold off;


%% 2.

% Split data into two subplots:
%   Left subplot: the summed approximation only.
%   Right subplot: all the individual sin components.

figure('Name','Square Wave Subplots');
sgtitle('Fourier Series: Summed vs. Components');

% Left Subplot: Summation
subplot(1, 2, 1);
plot(tPoints, squareApprox, 'LineWidth', 1.5, 'Color','b');
title('Summed Approximation');
xlabel('t');
ylabel('Amplitude');
xlim([tPoints(1), tPoints(end)]);
xticks([-pi, -pi/2, 0, pi/2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
ylim([-1.2, 1.2]);
grid on;

% Right Subplot: Individual Components
subplot(1, 2, 2);
plot(tPoints, allTerms);
title('Sine Components');
xlabel('t');
ylabel('Amplitude');
xlim([tPoints(1), tPoints(end)]);
xticks([-pi, -pi/2, 0, pi/2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
ylim([-1.2, 1.2]);
grid on;


%% 3. 

% Surface Plot of z = x sin(x) - y cos(y)
% Create a mesh over [-2π, 2π] x [-2π, 2π].
% Then define Z = X.*sin(X) - Y.*cos(Y), and plot it with 'surf'.

nGrid = 64;  % Number of points in each dimension
xVals = linspace(-2*pi, 2*pi, nGrid);
yVals = linspace(-2*pi, 2*pi, nGrid);

[X, Y] = meshgrid(xVals, yVals);
Z = X .* sin(X) - Y .* cos(Y);  % Function definition

figure('Name','Surface Plot');
surf(X, Y, Z);
title('z = x sin(x) - y cos(y)');
xlabel('x');
ylabel('y');
zlabel('z');
shading interp;  % Smooth shading for better visualization
colormap jet;
colorbar;


%% Extra: Plot the MATLAB Logo
% MATLAB function "membrane" reproduces a surface resembling the MATLAB logo. 

figure('Name','MATLAB Logo');
logoData = membrane(1, 25);   % Generate a membrane-based surface
surf(logoData);
title('MATLAB Logo');
axis tight;
shading interp;
colormap parula;
colorbar;
