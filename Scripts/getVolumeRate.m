%% get the volume rate per minute
Fs = 100;

flowrsample = flowr;
fpl = flowrsample(flowrsample >= 0);
X = 1:length(flowrsample);
X_ = X(flowrsample >= 0);

% volume rate per 
volrate = cumsum(fpl)./(X_)/Fs;

figure;
clf; hold on;
plot(X, volr/1000, 'b')
plot(X_, volrate*60/Fs, 'k')