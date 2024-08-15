function noiseout = my_whitnoise(duration, fs, level)
 
% Creates white noise based on duration, sampling frequency and level
 
% Inputs:
% duration - Duration of noise in seconds
% fs - Sampling frequency in Hertz
% level - Level of signal in dB (must range between negative and 0 dB) 
% Output:
% noiseout - Noise signal
 
duration_in_samples =round(duration * fs) ; % Calculate required number of samples
% based on the duration of signal and sampling rate.
 
random_signal = rand(duration_in_samples, 1); % Create a vector of random
% values according to the number of samples (n rows) and for one channel (m column).
 
random_signal_audio = random_signal - 0.5; % Scale the signal to a range 
% between -0.5 to +0.5 amplitude.
 
level_in_amplitude = db2mag(level); % Convert the level from decibels 
% (ratio) to magnitude (target value) using the built-in function db2mag.

% normalise the resulting signal and scale its gain 
noiseout = random_signal_audio./max(abs(random_signal_audio)).*level_in_amplitude; 
end
