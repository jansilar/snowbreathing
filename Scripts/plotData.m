function plotData(xData, varNames, iCol, multiplier)
  if nargin<4 
    multiplier = ones(size(iCol,2));
  end
  for i = 1:size(iCol,2)
    plot(xData(:,1), xData(:,iCol(i)+1)*multiplier(i), num2str(i));
  end;
  xlabel('time (s)');
  legend(varNames(iCol));
end;