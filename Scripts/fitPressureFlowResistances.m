%% prepares the vector of pressure-flow fit fucntion parameters for all datasets
clear;
close all;
doPlot = true;

datafile.name = 'c004-3m0200';
datafile.range = (11106:11712);
datafile.PressFlowPos = [3 4];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c004-4m2000';
datafile.range = (18623:19101);
datafile.PressFlowPos = [3 4];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c004-8S2000';
datafile.range = (18087:18752);
datafile.PressFlowPos = [3 4];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c004-11m2000';
datafile.range = (18130:18782);
datafile.PressFlowPos = [3 4];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c007-01m2000';
% datafile.range = ();
% pressure NA
datafile.PressFlowPos = [];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c007-07m2000';
% pressure data are bad in the first half of the snowbreathing
% datafile.range = ();
datafile.PressFlowPos = [];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c007-08s2000';
datafile.range = (23036:23532);
datafile.PressFlowPos = [3 4];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c013-001m2000';
datafile.range = (18436:18698);
% datafile.range = {15247:15420};
datafile.PressFlowPos = [4 5];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c013-12m2000';
datafile.range = (16079:16350);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [4 5];
dataset(length(dataset) + 1) = datafile;

datafile.name = 'c013-12s2000';
% wrong pressure data
datafile.range = (14017:14557);
% datafile.range = {12566:12895};
datafile.PressFlowPos = [4 5];
dataset(length(dataset) + 1) = datafile;

% datafile.name = 'c007-01m2000';
% % mising pressure data
% datafile.range = (0);
% % datafile.range = {12566:12895};
% datafile.PressFlowPos = [];
% dataset(length(dataset) + 1) = datafile;
% 
% 
% datafile.name = 'c007-07m2000';
% datafile.range = (22583:22867);
% % datafile.range = {12566:12895};
% datafile.PressFlowPos = [3 4];
% dataset(length(dataset) + 1) = datafile;
% 
% datafile.name = 'c007-08s2000';
% datafile.range = (23036:23478);
% % datafile.range = {12566:12895};
% datafile.PressFlowPos = [3 4];
% dataset(length(dataset) + 1) = datafile;
%% dataset check
for i = 1:length(dataset)
    df = dataset(i);
    disp(df.name)
end

%%
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
    press = data(:, df.PressFlowPos(1));  
    flow = data(:, df.PressFlowPos(2));
    %   vol = data(:, 5).';

    N = length(data);
    X = 1:N;

    flowRepair.invalidReading = [0, -0.1, -0.2];
    flowRepair.manuallyInvalidated = [];
    flowRepair.diffBounds = [];

    % first iteration - remove invalid readings
    flow2 = filterFlowData(flow, flowRepair, doPlot);
    if doPlot
        title([df.name ': fitted segment']);
        axis([df.range(1), df.range(end), -150, 150]);
    end
    % second iteration - normalize the volume drift
    flow3 = adjustVolumeTrend(flow2, doPlot);
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
        disp('Press any klavesa');
        pause;
    end
end

%% results
disp('results of datafit:')
disp('(flowr = a*pressure^b)');
for i = 1:numel(pfpar)
    p = pfpar(i);
    str = [p.name  ':  a = ' num2str(p.pc(1)) '; b = ' num2str(p.pc(2)) ...
        '; rms = ' num2str(p.rms) ';\n'] ;
    fprintf(str);
    pc(i, :) = p.pc;
    if ~isempty(p.rms)
        rmsf(i) = p.rms;
    end
end

pc
%% output (as of 25/04/2018)
% results of datafit:
% (flowr = a*pressure^b)
% c004-3m0200:  a = 8.3092; b = 0.75299; rms = 0.66241;
% c004-4m2000:  a = 23.9068; b = 0.62385; rms = 0.9447;
% c004-8S2000:  a = 21.9101; b = 0.66882; rms = 0.93157;
% c004-11m2000:  a = 41.9025; b = 0.44409; rms = 0.76705;
% c007-01m2000:  a = NaN; b = NaN; rms = ;
% c007-07m2000:  a = NaN; b = NaN; rms = ;
% c007-08s2000:  a = 26.5324; b = 0.58096; rms = 0.9169;
% c013-001m2000:  a = 27.9283; b = 0.57865; rms = 0.87821;
% c013-12m2000:  a = 34.5846; b = 0.49006; rms = 0.78916;
% c013-12s2000:  a = 40.3842; b = 0.35159; rms = 0.34802;

% rmsf = [0.662405738202898 0.944703107800159 0.931572019726833 0.767045458243457 0 0 0.916896443091910 0.878206709467596 0.789163298586110 0.348022524298846]
% pc = [8.30923743584637 0.752988212277250;23.9068165317125 0.623852449974399;21.9100858312861 0.668824825771512;41.9024729978247 0.444088763085921;NaN NaN;NaN NaN;26.5324266345760 0.580959749656601;27.9282632900626 0.578651143635137;34.5845675173883 0.490061104791459;40.3841664676452 0.351586023378974]