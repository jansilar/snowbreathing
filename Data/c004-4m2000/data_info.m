#specific part:
#--------------
#file names:
fileT = 'trends--c004-4m2000.txt';
fileTD = 'dutina-trends-c004-4m2000.txt';
fileW = 'waves-c004-4m2000.txt';
fileWD = 'dutina-waves-c004-4m2000-pr.txt';

varNameT = {"HR", "SpO2"};
varNameW = {"CO2", "O2", "Paw", "Flow", "Vol"};
varNameWD = {"CO2_D", "O2_D"};

#columns plotted to find the offsets:
varIT = 1;
varIW = 1;
varIWD = 1;

#sample frequencies (Hz):
fT = 1;
fTD = 1;
fW = 25;
fWD = 100;
fTarget = 100;

#column indexes with variables of interest:
columnT = [1 30];
#columnTD = [1 30];
columnW = [1:5];
columnWD = [2:3];

#crop times
cropT = [0 1130];
#cropfTD;
cropW = [177 1040];
cropWD = [319 1267];#[446 1267];

#crop times for simulation input data
cropWSimul = [177 1230];
cropWDSimul = [319 1230];



#time when the cone was disconnected (after first crop):

commonShift = -332;

tEndT = 894 + commonShift;
#tEndTD
tEndW = 918 + commonShift;
tEndWD = 801-1.7 + commonShift;

