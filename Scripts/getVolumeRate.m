%% get the volume rate per minute
Fs = 25;

flowrsample = flow3;

fpl = flowrsample(flowrsample >= 0);
X = 1:length(flowrsample);
X_ = X(flowrsample >= 0);

% volume rate per 
volrate = cumsum(fpl)./(X_)/Fs;

figure;
clf; hold on;
plot(X, cumsum(flow3)/1000, 'b')
plot(X_, volrate*60, 'k', 'linewidth', 2)