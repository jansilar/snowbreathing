function flowr = repairFlowData22(flow2, doPlot) 
%% Head
% pkg load signal
%low-pass filter design:
    pkg load signal;
    order = 4;
    cutoff = 0.001;
    [b,a] = butter(order, cutoff);


    N = length(flow2);
    X = 1:N;
    
    vol = cumsum(flow2);
    tt = filter(b,a,vol);

%    [p, s, mu] = polyfit(X, vol, 6);
%    tt = polyval(p,X,[],mu);

    volr = vol - tt;

    flowr = [0, diff(volr)];

    % reconstructed volume - just for check
    rvol = cumsum(flowr);
    if (doPlot)
        figure; hold on;
        plot(X, vol, 'b')
        plot(X, tt, 'k')

        plot(X, flow2*50, 'b')
        plot(X, flowr*50, 'r')

        plot(X, rvol, 'm')
        legend('volume', 'vol_fit','flow','flowr','volr')
    endif;














