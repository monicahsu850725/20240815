function outwave = delay_one_channel(inwave, delay_samples)
 
% This function generates a two-channel audio signal from a one-channel audio  
% signal and delays one of its channels to simulate a sound source that  
% originates at a specific angle relative to the listener's head. 

% Input arguments:
% inwave = one-channel audio signal
% delay_samples = ITD in samples

% Output argument:
% outwave = two-channel audio signal

% create a vector of zeros values
extra_samples = zeros(delay_samples, 1); 

% concatenate the vector of zero values with the input signal 
% (zero-padding at the start)  
signal_delayed = [extra_samples; inwave]; 

% concatenate the vector of zero values with the input signal 
% (zero-padding at the end)
signal_no_delay = [inwave; extra_samples]; 
 
% construct the two-channel signal
outwave = [signal_delayed, signal_no_delay]; 
 
end
