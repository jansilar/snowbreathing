function di = c013_12s2000_data_info()
    %file names:
    %fileT = 'trends-c013-001m2000.txt';
    %fileTD = 'dutina-trends-c013-001m2000.txt';
    di.baseName = 'c013-12s2000';
    di.W.file = 'waves-c013-12s2000.txt';
    di.WD.file = 'dutina-waves-c013-12s2000.txt';

    di.T.varName = {'HR', 'SpO2'};
    di.W.varName = {'CO2', 'O2', 'N2O', 'Paw', 'Flow', 'Vol'};
    di.WD.varName = {'CO2_D', 'O2_D'};
    
    %column indexes with variables to read:
    %columnT = [1 30];
    %columnTD = [1 30];
    di.W.column = [1:6];
    di.WD.column = [2:3];

    %columns to plot
    di.T.varI = 1;
    di.W.varI = [1 2 4];
    di.WD.varI = [1 2];

    %sample frequencies (Hz):
    di.T.f = 1;
    di.TD.f = 1;
    di.W.f = 25;
    di.WD.f = 100;
    di.fTarget = 25;

    %crop times for simulation input data
    di.W.crop = [142 856.5];
    di.WD.crop = [0 950];

    %time when cone was connected
    di.W.tConnected = 439;
    di.WD.tConnected = 387-3.7;%-2.7-1.4 + 0.5 + 3.52;

    %time when the cone was disconnected:
    di.W.tDisconnected = 729.04;
	
	% repair the flow - if the pc exist,then the rest is not required and vice versa
	%di.flowRepair.pc = [NaN NaN];
	% points and spans to be invalidated
	di.flowRepair.manuallyInvalidated = [];
	% set of "bad readings" - these values are discarded
	di.flowRepair.invalidReading = [-0.1, -0.2, -0.2];
	% when the diffbounds are empty, the saturation correction is skipped
	% [min, max, maxwidth] - min peak of diff, max peak of diff and maximal width of sat
	di.flowRepair.diffBounds = [-90, 40, 40];
end

