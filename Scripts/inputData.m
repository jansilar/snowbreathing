function inputData(dir,setImpDat)
  %read the dataInfo file:
  filePath = ['../Data/' dir '/']
  di = readDataInfo(filePath);
  close all;
  %[xW, dataW] = processOne(fileW, columnW, filePath, fW , fTarget, cropWSimul, tEndW, varIW, varNameW, -1);
  [xW, dataW] = processOne(filePath, di, 'W', -1, setImpDat);
  [xWD, dataWD] = processOne(filePath, di, 'WD', -1, setImpDat);
  xdata = mergeData({xW, xWD}, {dataW, dataWD});
  varNames = [di.W.varName, di.WD.varName]
  figure;
  hold on;
  plotData(xdata, varNames, [1, 2, 3, 4, 6, 7], [1, 1, 1, 1/6, 1, 1]);
  CO2O2_100 = xdata(:,[1,7,8]);
  CO2O2 = avgDownsample(CO2O2_100, 20);
  save('-v4',[filePath 'CO2O2.mat'], 'CO2O2')  
  Flow_100 = xdata(:,[1,5]);
  Flow = avgDownsample(Flow_100,20);
  %set zero flow after disconnecting the mouthpiece
  Flow(Flow(:,1) > di.tDisconnected,2) = 0;
  %save to file
  save('-v4',[filePath 'Flow.mat'], 'Flow')  

%  figure;
%  plot(Flow_100(:,1),Flow_100(:,2));
%  figure;
%  plot(Flow(:,1),Flow(:,2));
%  legend('flow');
%  figure;
%  plot(CO2O2(:,1),CO2O2(:,2));
%  legend('CO2','O2')
%  hold on;
  %plot(CO2O2(:,1),CO2O2(:,3));
  
  %hold on;
  %plot(xdata(:,1),xdata(:,6))

end
