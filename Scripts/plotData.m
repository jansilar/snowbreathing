function plotData(xData, varNames, iCol, multiplier)
  if nargin<4 
    multiplier = ones(size(iCol,2));
  end
  colors = ['m' 'c' 'r' 'g' 'b' 'k' 'y' ];
  for i = 1:size(iCol,2)
    plot(xData(:,1), xData(:,iCol(i)+1)*multiplier(i), colors(i));
  end;
  xlabel('time (s)');
  legend(varNames(iCol));
end;