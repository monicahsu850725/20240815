function decay_curve = my_decay_function(decaytime, fs, decayfactor)
 
% Calculate an exponential decay curve based on reverb time and sampling 
% frequency
 
% Inputs:
% decaytime - Reverb time in seconds
% fs - Sampling frequency in Hertz
% decayfactor - Decay factor in dB
 
% Output:
% decay_curve - Vector of decay
 
samples = decaytime*fs; % Calculate required number of samples based on the 
% reverb time and sampling rate
 
initialvalue = 1; % Set initial value for the curve (maximum magnitude)
 
factor_value = db2mag(decayfactor); % Convert the decay factor from decibels 
% (ratio) to magnitude (target value) using the built-in function db2mag.
 
decay_curve = zeros(samples,1); % Locate a vector for the decay curve 
% according to the number of samples (n rows) and for one channel 
% (m column). This vector is initialised with all cell values equal to zero.   
 
% To calculate the exponential decay function, a recursive operation is 
% used (for loop). A counter t is created as a vector that goes from 1 to 
% the number of samples. The created decay curve vector starts from the 
% initial value (maximum magnitude) and ends at the specified number of 
% samples with zero magnitude.    
    for t = 1:samples
        decay_curve(t) = initialvalue*(factor_value^(-t/samples));
 
    end
 
decay_curve = decay_curve - min(decay_curve); % Ensure decay curve goes 
% to zero at it's minimum
 
end
