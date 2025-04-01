% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw6_fourYearTransform.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1. 
% Define Sampling Rate and db2mag
fs = 96e3;  % 96 kHz sampling rate

% Anonymous function to convert dB to linear magnitude
db2mag = @(dB) 10.^(dB / 20);

%% 2.
% Generate a Composite Signal + Noise, Then Plot FFT in dB
N = 192e3;                 % Number of samples: 192k
Ts = 1 / fs;               % Sampling period
t = (0:N-1) * Ts;          % Time vector

% Frequencies (Hz) and their dB amplitudes
freqList = [-20.48e3, -360, 996, 19.84e3];
amp_dB   = [14, -10, 0, 2];

% Convert dB amplitudes to linear scale
ampLin = db2mag(amp_dB);

% Build the signal by summing complex exponentials
sig = zeros(size(t));
for k = 1:length(freqList)
    sig = sig + ampLin(k) * exp(1j * 2 * pi * freqList(k) * t);
end

% Add white noise at -10 dB
noiseAmp = db2mag(-10);
sig = sig + noiseAmp * randn(size(sig)); %% #ok<RAND>

% Compute FFT and shift for plotting from -fs/2 to fs/2
SIG = fftshift(fft(sig));
freqAxis = fs/N * (-N/2 : N/2 - 1);

% Plot magnitude spectrum in dB
figure('Name','Composite Signal Spectrum');
plot(freqAxis, 20*log10(abs(SIG)));
xlim([-fs/2, fs/2]);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('FFT of Composite Signal');

%% 3. 
% Zeros-Poles of a Filter + Frequency Response
% Given zeros, poles, and gain from the assignment:
zZeros = [0.76+0.64j,  0.69+0.71j,  0.82+0.57j];
zZeros = [zZeros, conj(zZeros)];  % Conjugates for the complex pairs

pPoles = [0.57+0.78j, 0.85+0.48j];
pPoles = [pPoles, conj(pPoles), 0.24, 0.64];  % Add conj. and real poles

kGain = 0.53;  % Overall gain

% Plot the pole-zero diagram
figure('Name','Pole-Zero Diagram');
zplane(zZeros.', pPoles.');
title('Pole-Zero Plot of the Filter');

% Convert zero-pole form to polynomial form
[bCoeff, aCoeff] = zp2tf(zZeros.', pPoles.', kGain);

% Evaluate frequency response from 0 to fs/2
fAxis = linspace(0, fs/2, 1000);
H = freqz(bCoeff, aCoeff, fAxis, fs);

% Magnitude (dB) and Phase (deg)
magResp = 20 * log10(abs(H));
phaseResp = unwrap(angle(H)) * (180 / pi);

% Plot magnitude and phase responses
figure('Name','Filter Response');
sgtitle('Magnitude & Phase of H');

subplot(2, 1, 1);
plot(fAxis, magResp, 'LineWidth', 1.2);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response');
xlim([0, fs/2]);

subplot(2, 1, 2);
plot(fAxis, phaseResp, 'LineWidth', 1.2);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
title('Phase Response');
xlim([0, fs/2]);
