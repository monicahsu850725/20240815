% Add clear command
clear
close all
clc

% sound_selection.
sound_selected = input('\n Do you want to use densil or snare or music?\n\n >','s');

% Test whether the user seletced cello using an 'if' statement. Remember 
% that the user's selection is assigned to the variable: sound. 
 
if strcmp(sound_selected,'densil')
     [inwave,fs] = audioread('densil.wav');
 
elseif strcmp(sound_selected,'snare')
     [inwave,fs] = audioread('snare.wav');

elseif strcmp(sound_selected,'music')
     [inwave,fs] = audioread('analyse_tune.wav');

% Add a final 'else' condition that uses the built-in function 'error' to indicate
% that the user's selection is invalid 
else 
    error('you may select only densil or snare or music');

% Complete the 'if-else' statement by adding 'end' command.
end

% Normalise the variable: sound
inwave = inwave./max(abs(inwave));

% Display the following message in the command window: 'How far is the sound from you?, following the recommended range of 1-10 m.' 
% use the built-in function 'input', and name the output argument: r
r = input(['How far is the sound from you?,' ...
    ' the recommended range of 1-10 m\n\n']);

% Display the following message in the command window: 'What is the azimuth angle of the sound from you?, following the recommended ranging from 0 to 355 degrees with a 5-degree interval.' 
% use the built-in function 'input', and name the output argument: angle
angle = input(['What is the azimuth angle of the sound from you?, ' ...
    ' the recommended ranging from 0 to 355 degrees with a 5-degree interval\n\n']);

% distance effect by user parameter: sound(inwave), distance(r) and
% fs(sound)
outwave = Distance_effect (inwave,r, fs);

load small_pinna % load HRIR data for small pinna

%HRIR processing by outwave and user parameter:angle
outwave2 = HRIRprocessing(outwave, angle, left, right);

%nomalise
outwave2 = outwave2 ./ max(abs(outwave2));

%play
sound(outwave2,fs);

%save audio output
audiowrite('demo.wav',outwave2,fs)



