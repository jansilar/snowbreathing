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

function [xOut, dataOut] = cropData(x, data, cropTimes) 
  cropI1 = find(x>cropTimes(1),1,'first');
  cropI2 = find(x<cropTimes(2),1,'last');
  size(x)
  cropI1
  cropI2
  xOut = x(cropI1:cropI2);
  dataOut = data(cropI1:cropI2,:);
endfunction;

function xOut = doOffset(x,offset)
  xOut = x - offset;
endfunction;

function [x, data] = processOne(file, rows, dir, f1, f2, crop, tEnd, varI, varName)
  data = importdata([dir "/" file],"\t",3).data(:,rows);
  [x, data] = resampleX(data,f1,f2);
  #to find crop ranges:
  #plot((xT,dataT(:,varIT));
  [x,data] = cropData(x,data,crop);
  #to find final experiment time:
  #plot(xT,dataT(:,varIT));
  x = doOffset(x,tEnd);
  #to see zero time in the end of experiment:
  plot(x,data(:,varI));
  title(file);
  xlabel("time [s]");
  ylabel(varName(varI));
endfunction;

function [x, data] = mergeData(xs, datas)
  if (size(xs) != size(datas))
    error("x and data are of different size in mergeData");
  end if;
  #TODO: find maximal star and minimal end values in x, crop all data and create common x
endfunction;

files = {fileT; fileTD; fileW; fileWD};
f = [fT fTD fW fWD];
offsets = [offsetT offsetTD offsetW offsetWD];


varNameW = {"CO2", "O2", "Paw", "Flow", "Vol"};
varNameT = {"HR", "SpO2"};


close all;
#TRENDS
varIT = 1;
varIW = 3;

#TODO: write processAll function

[xT, dataT] = processOne(fileT, rowsT, dir, fT, fW, cropT, tEndT, varIT, varNameT);
figure;
[xW, dataW] = processOne(fileW, rowsW, dir, fW, fW, cropW, tEndW, varIW, varNameW);

[x, data] = mergeData({xT, xW}, {dataT, dataW});
