function [x2,dataRe] = resampleX(data,f1,f2)
%resample function:

%  rows = size(data)(1)
%  x1 = 1:1:rows;
  x1 = createX(data,f1,f1);
  x2 = createX(data,f1,f2);
  dataRe = interp1(x1,data,x2,'linear');
end