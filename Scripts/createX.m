function x2 = createX(data, f1, f2)
  %f1 orig sample f in data
  %f2 new sample f
  rows = size(data)(1);
  endX = (rows-1)/f1;
%  dx1 = 1.0/f1;
  dx2 = 1.0/f2;
  x2 = 0:dx2:endX;
end;
