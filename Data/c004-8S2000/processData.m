#specific part:
#--------------
clear all;
#file names:
fileT = 'c004-8S2000-trends.asc';
fileTD = 'dutina-c004-8S2000-trends.asc';
fileW = 'c004-8S2000waves.asc';
fileWD = 'dutina-c004-8S2000-waves-tr.asc';

#sample frequencies (Hz):
fT = 1;
fTD = 1;
fW = 25;
fWD = 25;

rowsT = [1 30];
#rowsTD = [1 30];
rowsW = [1:5];
#rowsWD = [1:5];

#crop times
cropT = [194 1170];
#cropfTD;
cropW = [302 1125];
#cropfWD;

#time when the cone was disconnected (after first crop):
tEndT = 964;
#tEndTD
tEndW = 972;
#tEndWD


#offsets in ms:
offsetT = 0;
offsetTD = 0;
offsetW = 0;
offsetWD = 0;

dir = pwd;

run("../processDataCommon.m")