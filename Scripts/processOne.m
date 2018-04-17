function [x, data] = processOne(filePath, dif, dic, repairColumn)
  %read the data from file:
  ['reading ' filePath dif.file]
  data = importdata([filePath dif.file],'\t',3).data(:,dif.column);
  if (repairColumn > 0)
    if (nargin < 11)
      error('mi must be given as argument of processOne function in order to repair data.');
    endif;
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData(toRepCol', mi, [-0.1, -0.2, -0.2], [-110, 40, 20], false);
    data(:,repairColumn) = repaired;
  endif;
  %resample data, return new time grid as well. f1 .. original sample rate, f2 .. new sample rate.
  [x, data] = resampleX(data,dif.f,dic.fTarget);
  %------------------ Uncoment to find crop time range (crop_): ----------------------
  
  %plot(x,data(:,varI));
  %error('Find the times to crop out the nonsens data on boundaries.')
  %---------------------------------------------------------------------------
  
  %crop the starting and final data with nonsens values
  [x,data] = cropData(x,data,dif.crop);
  
  %----------------- Uncomment to find the time, when cone was disconnected (tEnd_)------
 % plot(x,data(:,varI));
 % error('Find the time, when cone was disconnected')
  %--------------------------------------------------------------------------------------

  %offset in time so that the zero time is when the snow come is connected
  x = doOffset(x,dif.tConnected, dic.fTarget);
   %plot(x,data(:,varI));
  %error('Plotting data with offset')
  %repair flow data so that flow integral has constant tendency
  if (repairColumn > 0)
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData22(toRepCol', true);
    data(:,repairColumn) = repaired;
  endif;
  
  %------------ Uncomment to see the result ----------------------------
%    plot(x,data(:,dif.varI));
%    title(dif.file);
%    xlabel('time [s]');
%    ylabel(dif.varName(dif.varI));
  %---------------------------------------------------------------------
%  error("procvessOneFinished")
end;
