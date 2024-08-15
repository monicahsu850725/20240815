function outsig = my_simple_reverb(insig, fs, reverbduration, decayfactor,level, maxlevel)
 
% Convolve an input signal with a decaying noise signal to simulate reverb
 
% Inputs:
% insig - Input signal for processing
% fs - Sampling frequency in Herz
% reverbduration - Reverb time in seconds
% decayfactor - Decay factor in dB
% level - Level of the white noise signal in dB
% maxlevel - Maximum level of the resulting signal in dB full scale (e.g. -6)
 
% Output:
% outsig - Reverberant signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% convert maxlevel level from dB to magnitude
maxlevel_amplitude = db2mag(maxlevel); 

% determine the size of the input signal using the built-in function size. 
% The number of samples corresponds to the number of rows and the number of
% channels corresponds to the number of columns. 
% We are interested in the number channels (column dimension)
% only, so we prevent the function from returning both output arguments
% using tilde symbol ~
[~, channels] = size(insig); 

% generate a decay curve by calling my_decay_function
decay_curve = my_decay_function(reverbduration, fs, decayfactor);

% Add a conditional operation using if-else statement to apply different 
% operations if the input signal is a one channel or two channels. 
 
if channels == 1 % expression 1 is defined using rational operator 

    % generate a noise signal by calling my_whitnoise
    noisesig = my_whitnoise(reverbduration, fs, level); 

    % generate a decaying signal 
    decaying_signal = decay_curve .* noisesig; 

    % convolve the input signal with the decaying signal using the built-in 
    % function conv to create a simple reverb simulation
    mono_conv_reverb = conv(insig, decaying_signal); 

    % Normalise the output signal and scale using the maxlevel_amplitude  

    outsig = mono_conv_reverb./max(abs(mono_conv_reverb)).*maxlevel_amplitude;
    
elseif channels == 2 % expression 2 is defined using rational operator
    
    % channel 1 processing: 
    noisesigL = my_whitnoise(reverbduration, fs, level);
    reverb_simL = decay_curve .* noisesigL;
    stereo_conv_reverbL = conv(insig(:,1), reverb_simL);
    outsigL = stereo_conv_reverbL./max(abs(stereo_conv_reverbL)).*maxlevel_amplitude;
    
    % channel 2 processing:
    noisesigR = my_whitnoise(reverbduration, fs, level);
    reverb_simR = decay_curve .* noisesigR;
    stereo_conv_reverbR = conv(insig(:,2), reverb_simR);
    outsigR = stereo_conv_reverbR./max(abs(stereo_conv_reverbR)).*maxlevel_amplitude;

    % reconstruct the stereo signal:
    outsig = [outsigL, outsigR]; 

% expression 3 is defined to prevent the processing of more than 2 
% channels signal
else 
    error('This function is suitable for the processing of up to 2 channel audio signal'); % error message is displayed in the Command window if the input file consists of more than two channels
 
end % of else-if statement
 
end % of the function

