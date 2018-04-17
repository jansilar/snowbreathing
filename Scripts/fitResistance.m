datafile.name = 'c013-001m2000';
datafile.range = (18436:18698);
% datafile.range = {15247:15420};
datafile.PressFlowPos = [4 5];
dataset(1) = datafile;

datafile.name = 'c013-12m2000';
datafile.range = (16079:16350);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [4 5];
dataset(2) = datafile;

doPlot = false;
for i = 1:length(dataset)
    df = dataset(i);
    % for each datafile
    file = ['../Data/' df.name '/' df.name 'wavesDots.asc'];
    raw_read = importdata(file,'\t',2);
    data = raw_read.data;
%   co2 = data(:, 1).';
%   o2 = data(:, 2).';
    press = data(:, df.PressFlowPos(1)).';  
    flow = data(:, df.PressFlowPos(2)).';
    %   vol = data(:, 5).';

    N = length(data);
    X = 1:N;

    flowRepair.invalidReading = [0, -0.1, -0.2];
    flowRepair.manuallyInvalidated = [];
    flowRepair.diffBounds = [];

    % first iteration - remove invalid readings
    flow2 = repairFlowData(flow(df.range), flowRepair, true);
%     % second iteration - normalize the volume drift
%     flow3 = repairFlowData22(flow2(df.range), true);
    [pc, rms] = fitResistancePower(flow2, press(df.range), doPlot);
    if doPlot
        title([df.name ' with rms ' num2str(rms)])
    end
    pfpar(i, :) = pc;
end

%% Reconstruct the flow

for i = 1:length(dataset)

    file = ['../Data/' dataset(i).name '/' dataset(i).name 'wavesDots.asc'];
    raw_read = importdata(file,'\t',2);
    press = raw_read.data(:, dataset(i).PressFlowPos(1)).';  

    % reconstruct raw flow - both pos and neg sides
    clear pos;
    clear flowrfp;
    pos = press >= 0;
    flowrfp( pos) =  pfpar(i, 1).*( press( pos)).^pfpar(i, 2);
    flowrfp(~pos) = -pfpar(i, 1).*(-press(~pos)).^pfpar(i, 2);
    flowrfpnorm = repairFlowData22(flowrfp, doPlot);
    if doPlot
        figure();clf;hold on;
        flow = raw_read.data(:, df.PressFlowPos(2)).';
        plot(flow, 'b', 'Linewidth', 1);
        plot(flowrfpnorm, 'r', 'Linewidth', 2);
    end
    
    
    raw_read.data(:, dataset(i).PressFlowPos(2)) = flowrfpnorm;
    
    fileW = ['../Data/' dataset(i).name '/' dataset(i).name 'wavesDotsFlowRec.txt'];
    fid=fopen(fileW,'w');                   % open a new file for writing
    fprintf(fid,'%s\n',strjoin(raw_read.textdata(:, 1)));  % write the header lines
    fprintf(fid,'%s\n',strjoin(raw_read.colheaders));     
%     for ix=1:length(raw_read.textdata) 
%         disp(char(raw_read.textdata(3)))
% %         fprintf(fid,'%s\n',char(raw_read.textdata(i)));  % write the header lines
%     end
    fprintf(fid,'%d ',raw_read.data');                  % then the data
    fid=fclose(fid); 
    
    
end
    

%% fit PQ resistance
figure;
clf; hold on;
plot(X, flowr, 'r');
plot(X, pressr*10, 'b')
% plot(co2*10, 'k')


% 8S2000
%rng = {1900:2222, 5900:6290, 7200:7600, 11640:11960};

% 11m2000
% rng = {7400:7800, 9700:10200, 10500:10800,14350:14600};

rng = {10576:10853, 13576:13911};
size(rng{1})
f1 = 122;
f2 = 121;
figure();
clf;
subplot(f1); hold on; plot(co2, 'k');
subplot(f2); hold on;
graphStyle = {'xb', 'om', '-xr', 'og'};
previewStyle = {'b', 'm', 'r', 'g'};

for i = 1:length(rng)
  secs = [false(1, rng{i}(1)-1), (rng{i} > 0), false(1, N-rng{i}(end))];
  subplot(f2); plot(press(secs), flow2(secs), graphStyle{i});
%  plot(pressavg(secs), flowavg(secs), graphStyle{i});
  subplot(f1); plot(X(secs), co2(secs), previewStyle{i}); 
end


%% linear fit
csvwrite('pq1.csv', [press(secs); flow2(secs)]);



%% reconstruct the flow
frfp = 30.28*(data(:, 4)).^0.5459; 

pos = press >= 0;
flowrfp(pos) = 30.28*press(pos).^0.5459;
flowrfp(~pos) = -30.28*(-press(~pos)).^0.5459;


figure;
clf;hold on;
plot(flow*50, 'k');
plot(flow, 'k');
plot(flowrfp);

plot(cumsum(flow));
figure;
plot(cumsum(flowrfpnorm), 'b');

flowrfpnorm = repairFlowData22(flowrfp, true);
plot(flowrfp, 'b', 'Linewidth', 1);
plot(flowrfpnorm, 'r', 'Linewidth', 2);
figure;
plot(co2)

csvwrite('flow-c13-001m200.csv', [flowrfpnorm',  flow']);
%% For c013-001m2000
% General model Power1:
%      f(x) = a*x^b
% Coefficients (with 95% confidence bounds):
%        a =       30.28  (28.34, 32.22)
%        b =      0.5459  (0.52, 0.5718)
% 
% Goodness of fit:
%   SSE: 5.207e+04
%   R-square: 0.8666
%   Adjusted R-square: 0.8663
%   RMSE: 11.17

%Linear model:
%     f(x) = a*x
%Coefficients (with 95% confidence bounds):
%       a =       11.49  (11.27, 11.71)
%
%Goodness of fit:
%  SSE: 7.023e+04
%  R-square: 0.6792
%  Adjusted R-square: 0.6792
%  RMSE: 14.59

%General model Power1:
%     f(x) = a*x^b
%Coefficients (with 95% confidence bounds):
%       a =       28.16  (26.89, 29.44)
%       b =      0.5739  (0.5518, 0.596)
%
%Goodness of fit:
%  SSE: 1.52e+04
%  R-square: 0.9306
%  Adjusted R-square: 0.9303
%  RMSE: 6.798


%% reconstruct flow from pressures
% linear
flowrfpl = 11.49*press;

% nonlin
pos = press >= 0;
flowrfp(pos) = 28.16*press(pos).^0.5739;
flowrfp(~pos) = -28.16*(-press(~pos)).^0.5739;

figure;
clf;hold on;
plot(flowr, 'b');
plot(flowrfpl, 'm');
plot(flowrfp, 'r');
plot(cumsum(flowrfp), 'k');
legend('original [repaired] flow', 'reconstructed linear', ...
  'reconstructed power', 'cummulative volume for nonlin');