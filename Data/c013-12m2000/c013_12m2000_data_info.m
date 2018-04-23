function di = c013_001m2000_data_info()
    %file names:
    %fileT = 'trends-c013-001m2000.txt';
    %fileTD = 'dutina-trends-c013-001m2000.txt';
    di.baseName = 'c013-12m2000';
    di.W.file = 'waves-c013-12m2000.txt';
    di.WD.file = 'dutina-waves-c013-12m2000.txt';

    di.T.varName = {'HR', 'SpO2'};
    di.W.varName = {'CO2', 'O2', 'Paw', 'Flow', 'Vol'};
    di.WD.varName = {'CO2_D', 'O2_D'};
    
    %column indexes with variables to read:
    %columnT = [1 30];
    %columnTD = [1 30];
    di.W.column = [1 2 4 5 6];
    di.WD.column = [2:3];

    %columns to plot
    di.T.varI = 1;
    di.W.varI = [1 2 3];
    di.WD.varI = [1 2];

    %sample frequencies (Hz):
    di.T.f = 1;
    di.TD.f = 1;
    di.W.f = 25;
    di.WD.f = 100;
    di.fTarget = 25;

    %crop times for simulation input data
    di.W.crop = [251 858];
    di.WD.crop = [0 1040];

    %time when cone was connected
    di.W.tConnected = 441.2;
    di.WD.tConnected = 381.2;

    %time when the cone was disconnected (after first crop):
    di.tDisconnected = 732.5;
end

