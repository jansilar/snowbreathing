function [x, data] = processOne(file, columns, filePath, f1, f2, crop, tEnd, varI, varName, repairColumn, mi)
  %read the data from file:
  ['reading ' filePath file]
  data = importdata([filePath file],'\t',3).data(:,columns);
  if (repairColumn > 0)
    if (nargin < 11)
      error('mi must be given as argument of processOne function in order to repair data.');
    endif;
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData(toRepCol', mi, [-0.1, -0.2, -0.2], [-110, 40, 20], false);
    data(:,repairColumn) = repaired;
  endif;
  %resample data, return new time grid as well. f1 .. original sample rate, f2 .. new sample rate.
  [x, data] = resampleX(data,f1,f2);
  %------------------ Uncoment to find crop time range (crop_): ----------------------
  
  %plot(x,data(:,varI));
  %error('Find the times to crop out the nonsens data on boundaries.')
  %---------------------------------------------------------------------------
  
  %crop the starting and final data with nonsens values
  [x,data] = cropData(x,data,crop);
  
  %----------------- Uncomment to find the time, when cone was disconnected (tEnd_)------
 % plot(x,data(:,varI));
 % error('Find the time, when cone was disconnected')
  %--------------------------------------------------------------------------------------

  %offset in time so that the zero time is in the end, when snow cpme was dosconnected
  x = doOffset(x,tEnd, f2);
   %plot(x,data(:,varI));
  %error('Plotting data with offset')
  %repair flow data so that flow integral has constant tendency
  if (repairColumn > 0)
    toRepCol = data(:, repairColumn);
    repaired = repairFlowData22(toRepCol', true);
    data(:,repairColumn) = repaired;
  endif;
  
  %------------ Uncomment to see the result ----------------------------
 %   plot(x,data(:,varI));
%    title(file);
%    xlabel('time [s]');
%    ylabel(varName(varI));
 %   error('See one processed dataset');
  %---------------------------------------------------------------------
end;
