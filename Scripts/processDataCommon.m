#To find and set prope crop times and the time, when cone was disconnected
# - comment out all but one calls of processOne
# - consecutively uncomment particular sections in processOne find the 
#         values and write them to data_info.m
clear all;

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
  eps = 1.0e-8;
  cropI1 = find(x>=cropTimes(1)-eps,1,'first');
  cropI2 = find(x<=cropTimes(2)+eps,1,'last');
  xOut = x(cropI1:cropI2);
  dataOut = data(cropI1:cropI2,:);
endfunction;

function xOut = doOffset(x,offset, f)
  #round the offset to multiple of dt
  offsetR = round(offset*f)/f;
  xOut = x - offsetR;
endfunction;

function [x, data] = processOne(file, columns, filePath, f1, f2, crop, tEnd, varI, varName)
  #read the data from file:
  ["reading " filePath file]
  data = importdata([filePath file],"\t",3).data(:,columns);
  #resample data, return new time grid as well. f1 .. original sample rate, f2 .. new sample rate.
  [x, data] = resampleX(data,f1,f2);
  #------------------ Uncoment to find crop time range (crop_): ----------------------
  #plot(x,data(:,varI));
  #error("Find the times to crop out the nonsens data on boundaries.")
  #---------------------------------------------------------------------------
  
  #crop the starting and final data with nonsens values
  [x,data] = cropData(x,data,crop);
  
  #----------------- Uncomment to find the time, when cone was disconnected (tEnd_)------
#  plot(x,data(:,varI));
#  exit("Find the time, when cone was disconnected")
  #--------------------------------------------------------------------------------------

  #offset in time so that the zero time is in the end, when snow cpme was dosconnected
  x = doOffset(x,tEnd, f2);
  
  #------------ Uncomment to see the result ----------------------------
#    plot(x,data(:,varI));
#    title(file);
#    xlabel("time [s]");
#    ylabel(varName(varI));
#    exit("See one processed dataset");
  #---------------------------------------------------------------------
endfunction;

function [xdataOut] = mergeData(xs, datas)
  if (size(xs) != size(datas))
    error("x and data are of different size in mergeData");
  endif;
  size(xs)
  xL = -inf;
  xR = inf;
  for i = 1:size(xs,2)
    x = xs{i};
    xL = max(xL, x(1));
    indR = size(x,2);
    xR = min(xR, x(indR));
  end;
  [xdataOut, data1] = cropData(xs{1}, datas{1}, [xL,xR] );
  xdataOut = [xdataOut' data1];
  for i = 2:size(xs)(2)
    [_, data1] = cropData(xs{i}, datas{i}, [xL,xR] );
    xdataOut = [xdataOut data1];
  end;
endfunction;

function plotData(xData, varNames, iCol, multiplier)
  if nargin<4 
    multiplier = ones(size(iCol,2));
  end
  for i = 1:size(iCol,2)
    plot(xData(:,1), xData(:,iCol(i)+1)*multiplier(i), num2str(i));
  endfor;
  xlabel("time (s)");
  legend(varNames(iCol));

endfunction;

function writeData(data, header, file)
  textHeader = strjoin(header, '\t');
  %write header to file
  fid = fopen(file,'w')
  fprintf(fid,'%s\n',textHeader)
  fclose(fid)
  %write data to end of file
  dlmwrite(file,data,"\t", '-append')
  ["data written to " file " file\n"]
endfunction;

function newData = avgDownsample(data,n)
  #replace n consequent data samples by their average
  newData = [];
  nCols = size(data,2);
  row = zeros(1,nCols);
  iNew = 0;
  for i = 1:size(data,1)
    row = row + data(i,:);
    if mod(i,n) == 0
      newData = [newData; row/n];
      row = zeros(1,nCols);
    endif;
  end;
end;
    

function processData(dir)
  #read the dataInfo file:
  filePath = ["../Data/" dir "/"]
  run([filePath "/data_info.m"])

  files = {fileT; fileTD; fileW; fileWD};
  #frequencies:
  f = [fT fTD fW fWD];
  #offsets = [offsetT offsetTD offsetW offsetWD];



  close all;

  fTarget = 100;
  [xT, dataT] = processOne(fileT, columnT, filePath, fT , fTarget, cropT, tEndT, varIT, varNameT);
  [xW, dataW] = processOne(fileW, columnW, filePath, fW , fTarget, cropW, tEndW, varIW, varNameW);
  [xWD, dataWD] = processOne(fileWD, columnWD, filePath, fWD, fTarget, cropWD, tEndWD, varIWD, varNameWD);

  xdata = mergeData({xT, xW, xWD}, {dataT, dataW, dataWD});
  #xdata = mergeData({xT, xW}, {dataT, dataW});
  #error("debug")
  varNames = [varNameT, varNameW, varNameWD]
  figure;
  hold on;
  plotData(xdata, varNames, [3, 4, 5, 6,  8, 9], [1, 1, 1, 0.2, 1, 1], "x");

  writeData(xdata, ["t" varNames], [filePath dir "_all.txt"])
  CO2O2_100 = xdata(:,[1,9,10]);
  CO2O2 = avgDownsample(CO2O2_100, 20);
  save("-v4",[filePath "CO2O2.mat"], "CO2O2")  
  Flow_100 = xdata(:,[1,7]);
  Flow = avgDownsample(Flow_100,20);
  save("-v4",[filePath "Flow.mat"], "Flow")  

  figure;
  plot(Flow_100(:,1),Flow_100(:,2));
  figure;
  plot(Flow(:,1),Flow(:,2));
  
  #hold on;
  #plot(xdata(:,1),xdata(:,6))
endfunction;  




#processData("c004-8S2000");
processData("c004-4m2000");
