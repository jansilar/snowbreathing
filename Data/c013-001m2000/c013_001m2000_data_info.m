function di = c013_001m2000_data_info()
    %file names:
    %fileT = 'trends-c013-001m2000.txt';
    %fileTD = 'dutina-trends-c013-001m2000.txt';
    di.baseName = 'c013-001m2000';
    di.W.file = 'waves-c013-001m2000.txt';
    di.WD.file = 'dutina-waves-c013-001m2000.txt';

    di.T.varName = {'HR', 'SpO2'};
    di.W.varName = {'CO2', 'O2', 'Paw', 'Flow', 'Vol'};
    di.WD.varName = {'CO2_D', 'O2_D'};

    %columns plotted to find the offsets:
    di.T.varI = 1;
    di.W.varI = 1;
    di.WD.varI = 1;

    %sample frequencies (Hz):
    di.T.f = 1;
    di.TD.f = 1;
    di.W.f = 25;
    di.WD.f = 100;
    di.fTarget = 100;

    %column indexes with variables of interest:
    %columnT = [1 30];
    %columnTD = [1 30];
    di.W.column = [1 2 4 5 6];
    di.WD.column = [2:3];

    %crop times for simulation input data
    di.W.crop = [500 925];
    di.WD.crop = [0 1028];

    %time when cone was connected
    di.W.tConnected = 809-240.5;
    di.WD.tConnected = 753.3-240.5;

    %time when the cone was disconnected (after first crop):
    di.tDisconnected = 240.5;
	
	% repair the flow - if the pc exist,then the rest is not required and vice versa
	di.flowRepair.pc = [27.9283, 0.57865];
	di.flowRepair.manuallyInvalidated = [];
	di.flowRepair.invalidReading = [-0.1, -0.2, -0.2];
	di.flowRepair.diffBounds = [-90, 40, 30];
end

