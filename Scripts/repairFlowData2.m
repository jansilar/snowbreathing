function flowr = repairFlowData2(flow2, doPlot) 
%% Head
% pkg load signal

% data_dir = 'c004-3m0200';
%  data_dir = 'c004-4m2000';
%  data_dir = 'c004-8S2000';
%data_dir = 'c004-11m2000';
%  file = ['../Data/' data_dir '/' 'waves-c004-11m2000.txt'];
%  rowsW = [1, 2, 3, 4, 5];
%  rowsW = [1, 2, 3, 4];
%  fs = 25;

%% load data - pCO2, pO2, Flow

%  data_raw_read_d = importdata(file,'\t',3);
%  data_raw_read = data_raw_read_d.data(:,rowsW);
  
  % crop to 8k to 24k5
% data = data_raw_read(8000:24500, :);
%  data = data_raw_read;

%  N = length(data);
%  X = 1:N;
%  co2 = data(:, 1).';
%  o2 = data(:, 2).';
%  press = data(:, 3).';  
%  flow = data(:, 4).';
%   vol = data(:, 5).';

  
 % dataset c004-11m2000
%mi = [5000, 6650, 8030:8040,10265:10292, 12500, 14500, 16300:16327, 16387:16394, 16539:16552, 16704];
%flow2 = repairFlowData(flow, mi, [-0.1, -0.2, -0.2], [-110, 40, 20], false);

%flow2 = flow2(6666:16923);
    N = length(flow2);
    X = 1:N;
    
    vol = cumsum(flow2);
    [p, s, mu] = polyfit(X, vol, 6);
    tt = polyval(p,X,[],mu);

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














