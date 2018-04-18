%% prepares the vector of pressure-flow fit fucntion parameters for all datasets
clear;
close all;

doPlot = false;

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

datafile.name = 'c013-12s2000';
% wrong pressure data
datafile.range = (14017:14557);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [4 5];
dataset(3) = datafile;


datafile.name = 'c007-01m2000';
% mising pressure data
datafile.range = (0);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [];
dataset(4) = datafile;


datafile.name = 'c007-07m2000';
datafile.range = (22583:22867);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [3 4];
dataset(5) = datafile;

datafile.name = 'c007-08s2000';
datafile.range = (23036:23478);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [3 4];
dataset(6) = datafile;

for i = 1:length(dataset)
    df = dataset(i);
    pfpar(i).name = df.name;
    
    if isempty(df.PressFlowPos)
        % sometimes it is not possible to reconstruct
        pfpar(i).pc = [nan, nan];
        continue;
    end
    % for each datafile
    file = ['../Data/' df.name '/waves-' df.name '.txt'];
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
    flow2 = repairFlowData(flow, flowRepair, doPlot);
    if doPlot
        title([df.name ': fitted segment']);
        axis([df.range(1), df.range(end), -150, 150]);
    end
    % second iteration - normalize the volume drift
    flow3 = repairFlowData22(flow2, doPlot);
    if doPlot
        title([df.name ': normalizing the volume drift']);
        xlim([df.range(1), df.range(end)]);
        axis 'auto y';
    end
    
    [pc, rms] = fitResistancePower(flow3(df.range), press(df.range), doPlot);
    if doPlot
        title([df.name ': fit with rms ' num2str(rms)])
    end

    pfpar(i).pc = pc;
    pfpar(i).rms = rms;
    
    if doPlot
        pause;
    end
end

disp('results of datafit:')
disp('(flowr = a*pressure^b)');
for i = 1:numel(pfpar)
    p = pfpar(i);
    str = [p.name  ':  a = ' num2str(p.pc(1)) '; b = ' num2str(p.pc(2)) ...
        '; rms = ' num2str(p.rms) ';\n'] ;
    fprintf(str);
    pc(i, :) = p.pc;
end

%% output (as of 18/04/2018)
% results of datafit:
% (flowr = a*pressure^b)
% c013-001m2000:  a = 27.9283; b = 0.57865; rms = 0.87821;
% c013-12m2000:  a = 34.5846; b = 0.49006; rms = 0.78916;
% c013-12s2000:  a = 40.3855; b = 0.35157; rms = 0.34802;
% c007-01m2000:  a = NaN; b = NaN; rms = ;
% c007-07m2000:  a = 36.4536; b = 0.4297; rms = 0.78044;
% c007-08s2000:  a = 26.7716; b = 0.57583; rms = 0.91861;

% pc = [27.9282592900726 0.578651202433259;34.5846522616504 0.490060133371872;40.3848592701159 0.351576909686263;NaN NaN;36.4535547829029 0.429695965056082;26.7717112503667 0.575828949472075]