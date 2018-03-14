files = {fileT; fileTD; fileW; fileWD};
f = [fT fTD fW fWD];
offsets = [offsetT offsetTD offsetW offsetWD];

size(f)
break;
varNameW = ["CO2" "O2" "Paw" "Flow" "Vol"];
dataW = importdata(strcat(dir, "/", fileW),"\t",2).data;
varNameT = ["HR" "SpO2"];
dataT = importdata(strcat(dir, "/", fileT),"\t",3).data(:,[1 30]);

function x2 = createX(data, f1, f2)
  #f1 orig sample f in data
  #f2 new sample f
  rows = size(data)(1);
  endX = (rows-1)/f1;
#  dx1 = 1.0/f1;
  dx2 = 1.0/f2;
  x2 = 0:dx2:endX;
endfunction;

#resample function:
function [x2,dataRe] = resampleX(data,f1,f2)
#  rows = size(data)(1)
#  x1 = 1:1:rows;
  x1 = createX(data,f1,f1);
  x2 = createX(data,f1,f2);
  dataRe = interp1(x1,data,x2,'linear');
endfunction;

#resample trends data:
[xTRe, dataTRe] = resampleX(dataT,25);

#plot(x1,dataT,"*");
#figure;
plot(xTRe,dataTRe,"*")

#plot shifted:
#plot(x2+offset, dataTRe)

#close all;



