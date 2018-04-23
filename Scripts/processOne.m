function [x, data] = processOne(filePath, di, caseID, repairColumn, setImpData)
fprintf(['Processing ' caseID '\n']);
  di1 = di.(caseID);
  %read the data from file:
  filepath = [filePath di1.file];
  disp(['reading ' filePath di1.file]);
  data = importFile(filepath, di1.column);
  if (repairColumn > 0)
    if (nargin < 11)
      error('mi must be given as argument of processOne function in order to repair data.');
    end;
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData(toRepCol', mi, [-0.1, -0.2, -0.2], [-110, 40, 20], false);
    data(:,repairColumn) = repaired;
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
  
  %repair flow data so that flow integral has constant tendency
  if (repairColumn > 0)
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData22(toRepCol', true);
    data(:,repairColumn) = repaired;
  end;
  
  %------------ Uncomment to see the result ----------------------------
%    plot(x,data(:,dif.varI));
%    title([ dif.file ' ' caseID]);
%    xlabel('time [s]');
%    ylabel(dif.varName(dif.varI));
  %---------------------------------------------------------------------
    fprintf(['processing ' di.baseName ' ' caseID ' finished\n']);
end
