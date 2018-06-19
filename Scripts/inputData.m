function inputData(baseName,setImpDat, plotGrad, plotRepairFlow)
  if nargin < 3
      plotGrad = 0;
  end
  if nargin < 4
      plotRepairFlow = 0;
  end
  %read the dataInfo file:
  filePath = ['../Data/' baseName '/'];
  tuneFinished = ~setImpDat;
  
  close all;
  while (1)
%     close all;
    di = readDataInfo(baseName);
    [xW, dataW] = processOne(filePath, di, 'W', setImpDat, plotGrad,plotRepairFlow);
    [xWD, dataWD] = processOne(filePath, di, 'WD', setImpDat);
    xdata = mergeData({xW, xWD}, {dataW, dataWD});
    varNames = [di.W.varName, di.WD.varName];
    di.tDisconnected = di.W.tDisconnected - di.W.tConnected;
    figure(201); 
    items = get(gca, 'children');
    if length(items) > 1
        delete(get(gca, 'children')); axis manual; 
    end;
    hold on;
    toPlot = [di.W.varI di.WD.varI+size(di.W.column,2)];
    plotData(xdata, varNames, toPlot, [1, 1, 1, 1, 1]);
    plot(di.tDisconnected,0,'k+');
    setImpDat = 0;
    if tuneFinished
        break;
    end;

    key = input('If no more changes to the imput file is needed press \"0\",\n otherwise fine-tune parrameters and press any other key for another iteration\n');

    if key == 0
        tuneFinished = 1;
    end;
  end;
  
  % Save to the MAT files for modelica
  % time, CO2_cavity, O2_cavity, CO2_mouthpiece, O2_mouthpiece, flow
  varNames
  columns = [ [0,di.WD.varI+size(di.W.column,2), [1, 2]]+1, 5]
  CO2O2_25 = xdata(:,columns);
  %  CO2O2 = avgDownsample(CO2O2_100, 20);
  CO2O2 = CO2O2_25;
    
  clf; 
  subplot(211);hold on;
  plot(CO2O2(:,1),CO2O2(:,3));
  plot(CO2O2(:,1),CO2O2(:,5));
  subplot(212);hold on;
  plot(CO2O2(:,1),CO2O2(:,2));
  plot(CO2O2(:,1),CO2O2(:,4));
%   error('Šmitec')
  save('-v4',[filePath 'CO2O2.mat'], 'CO2O2')  
  
  Flow_25 = xdata(:,[1,5]);
  Flow = Flow_25;
%  Flow = avgDownsample(Flow_100,20);
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
