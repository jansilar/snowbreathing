#specific part:
#--------------
#file names:
fileT = 'c004-8S2000-trends.txt';
fileTD = 'dutina-c004-8S2000-trends.txt';
fileW = 'c004-8S2000waves.txt';
fileWD = 'dutina-c004-8S2000-waves-tr.txt';

varNameT = {"HR", "SpO2"};
varNameW = {"CO2", "O2", "Paw", "Flow", "Vol"};
varNameWD = {"Pleth" "CO2_D", "O2_D"};

#columns plotted to find the offsets:
varIT = 1;
varIW = 1;
varIWD = 1;

#sample frequencies (Hz):
fT = 1;
fTD = 1;
fW = 25;
fWD = 25;

#column indexes with variables of interest:
columnT = [1 30];
#columnTD = [1 30];
columnW = [1:5];
columnWD = [1:2];

#crop times
cropT = [194 1170];
#cropfTD;
cropW = [302 1125];
cropWD = [220 1360];

#time when the cone was disconnected (after first crop):
tEndT = 964;
#tEndTD
tEndW = 974.4;
tEndWD = 1049;
