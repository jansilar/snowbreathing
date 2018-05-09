function [x, data] = processOne(filePath, di, caseID, setImpData, plotGrad, plotRepairFlow)
  if nargin < 5
      plotGrad = 0;
  end
  if nargin < 6
      plotRepairFlow = 0;
  end

  fprintf(['Processing ' caseID '\n']);
  di1 = di.(caseID);
  %read the data from file:
  filepath = [filePath di1.file];
  disp(['reading ' filePath di1.file]);
  data = importFile(filepath, di1.column);

  % Repair flow data - either reconstruct from the pressure or filter the
  % existent flow data
  if strcmp(caseID,'W')
    data(:,di.W.columnFlow) = repairFlowData(data(:, di.W.columnFlow), data(:, di.W.columnPress),di.flowRepair, plotRepairFlow);
  end;
     
  %resample data, return new time grid as well. f1 .. original sample rate, f2 .. new sample rate.
  [x, data] = resampleX(data,di1.f,di.fTarget);

  msg = 'Find the times to crop out the nonsens data on boundaries,\n set in file and press any key.\n';
  [di, dif] = setImpDataCond(di, caseID, x, data, setImpData, msg);
  %crop-out the starting and final data with nonsens values
  [x,data] = cropData(x,data,dif.crop);

  msg = 'Find the time, when cone was connected (tConnected), set in file and press any key.\n';
  [di, dif] = setImpDataCond(di, caseID, x, data, setImpData, msg);

  if(caseID == 'W')
    msg = 'Find the time, when cone was disconnected (tDisconnected), set in file and press any key.\n';
    [di, dif] = setImpDataCond(di, caseID, x, data, setImpData, msg);
  end;
 

  %offset in time so that the zero time is when the snow come is connected
  x = doOffset(x,dif.tConnected, di.fTarget);
  
  %plot the full data with gradient if demanded:
  if plotGrad
      dataG = importFile(filepath, di1.column);
      [xG, dataG] = resampleX(dataG,di1.f,di.fTarget);
      xG = doOffset(xG,dif.tConnected, di.fTarget);
      figure();
      plot(xG,dataG(:,di1.varI));
      title('uncropped data');
      legend(di1.varName(di1.varI));
  end
  %repair flow data so that flow integral has constant tendency
%  if (repairColumn > 0)
%    toRepCol = data(:, repairColumn);
%    repaired = repairFlowData22(toRepCol', true);
%    data(:,repairColumn) = repaired;
%  end;
  
  %------------ Uncomment to see the result ----------------------------
%    plot(x,data(:,dif.varI));
%    title([ dif.file ' ' caseID]);
%    xlabel('time [s]');
%    ylabel(dif.varName(dif.varI));
  %---------------------------------------------------------------------
    fprintf(['processing ' di.baseName ' ' caseID ' finished\n']);
end

