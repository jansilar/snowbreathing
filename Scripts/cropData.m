function [xOut, dataOut] = cropData(x, data, cropTimes) 
  eps = 1.0e-8;
  cropI1 = find(x>=cropTimes(1)-eps,1,'first');
  cropI2 = find(x<=cropTimes(2)+eps,1,'last');
  xOut = x(cropI1:cropI2);
  dataOut = data(cropI1:cropI2,:);
end
