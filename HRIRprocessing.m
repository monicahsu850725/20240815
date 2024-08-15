function outwave = HRIRprocessing(inwave, angle, left, right)

% This function processes a one-channel audio signal using the HRIR set
% from the CIPIC database (small pinna) for an azimuth angle.
%
% Input arguments:
% inwave - one-channel audio signal
% angle - azumuth angle in degrees in a range of 0 to 355 in steps of 5
%
% Output arguments:
% outwave - resulting two-channel audio signal

if angle < 0
    angle = angle+360;
end

angle_idx = angle/5+1; % convert angle in degrees to index number

left_hrir = left(:,angle_idx); % extract the angle degrees HRIR
right_hrir = right(:,angle_idx); % extract the right angle degrees HRIR

signal= inwave; % load the audio file

l_signal = conv(signal, left_hrir); % convolve the audio signal with the HRIR for the left channel
r_signal = conv(signal, right_hrir); % convolve the audio signal with the HRIR for the right channel

outwave = [l_signal r_signal]; % concatenate the signals to crete a stereo signal
outwave = outwave./max(max(abs(outwave))); % normalise the resulting signal

