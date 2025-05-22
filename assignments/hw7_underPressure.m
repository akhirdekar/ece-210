% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw7_underPressure.m -- ECE210: MATLAB Seminar
% Copyright (C) 2025 Abhijeet Khirdekar <akhirdekar144@gmail.com>

clc;

%% 1)
url = 'https://raw.githubusercontent.com/jacobkoziej/jk-ece210/master/src/assignments/07-under-pressure.d/40p_1000ms.csv';
data = readmatrix(url);
t_samples = data(:,1);       % time-like index from CSV
adc_values = data(:,2);      % ADC output

%% 2) Normalize
adc_norm = (adc_values - min(adc_values)) / (max(adc_values) - min(adc_values));

%% 3) Compute & Plot the DFT
Fs = 80000;                   % sampling frequency
N = length(adc_norm);
freqs = (0 : N/2 - 1) * (Fs / N);
X = fft(adc_norm);
X_mag = abs(X(1 : N/2));
X_dB = 20 * log10(X_mag / max(X_mag));

figure;
plot(freqs, X_dB, 'b');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on;
title('DFT of Normalized Signal');
xlim([5 40]);                % focuses on lower frequencies

%% 4) Design an Elliptic Low-Pass Filter
Rp = 0.1;                    % passband ripple in dB
Rs = 40;                     % stopband attenuation in dB
f_pass = 20;                 % chosen passband edge (Hz)
f_stop = f_pass + 10;        % stopband edge (Hz)
[n, Wp] = ellipord(f_pass/(Fs/2), f_stop/(Fs/2), Rp, Rs);
[z, p, k] = ellip(n, Rp, Rs, Wp);
sos = zp2sos(z, p, k);       % second-order sections

% Plot Filter Response
[H, F] = freqz(sos, 1024, Fs);
H_dB = 20 * log10(abs(H));
figure;
plot(F, H_dB, 'b');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on;
title('Elliptic Filter Frequency Response');
xlim([5 f_stop + 20]);

%% 5) Filter the Signal
filtered_data = filtfilt(sos, 1, adc_norm);

%% 6) Plot Raw & Filtered Data
figure;
plot(t_samples / Fs, adc_norm, 'b', 'DisplayName', 'Raw Data'); hold on;
plot(t_samples / Fs, filtered_data, 'r', 'DisplayName', 'Filtered Data');
yline(mean(filtered_data), '--k', 'DisplayName', 'DC Bias');
xlabel('Time (s)'); ylabel('Normalized Voltage');
title('Raw vs. Filtered Signal');
legend('Location','best'); grid on;
