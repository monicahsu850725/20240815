function outwave = Distance_effect(inwave, r,fs)

% This function processes a one-channel audio signal using the distance effect.
%
% Input arguments:
% inwave - one-channel audio signal
% r - distance
% fs - selected audio frequency
%
% Output arguments:
% outwave - resulting distance effeccted audio signal

% make sure r is positive
if r < 0
    r = abs(r);
end

%LOW-PASS FILTER%
% Define filter specifications
cutoff_frequency = 20000; 
sampling_frequency = fs; 
%matlab lowpass filter
inwave_lowpass = lowpass(inwave,cutoff_frequency,sampling_frequency) ;



%ABSORPTION context%
%Citing from dissipation function by Densil C.(2015)
%alpha=absorption coeff (dB/m)
f_desired=(0:(fs/2));
alpha = dissipation (f_desired, 20, 50,100,1);
%nomalize f_desired
f_desired_nom=f_desired./(fs/2);
%make filter h
magnitude = 10.^((-alpha * r) / 20);
    h = fir2(128,f_desired_nom,magnitude)';

% Apply attenuation to the input signal
attenuated_signal =conv(inwave_lowpass,h);


% Plot the frequency response of the FIR filter  
freqz(h,1,1024, fs);


%REVERBERATION%
%classroom criteria according to AAAC, RT=0.4 
%decay_factor = -6 * log(10) / (2 * RT);
RT=0.4;
decay_factor=6*log(10) / (2*RT);

%reverberation effect by signal(attenuated_signal), audio frequency(fs),
%reverberation time(RT) and decay_factor
reverb_signal=my_simple_reverb(attenuated_signal,fs,RT,decay_factor,20,-6);

%output
outwave=reverb_signal

end

