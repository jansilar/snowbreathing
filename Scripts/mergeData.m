function [xdataOut] = mergeData(xs, datas)
  if (size(xs) != size(datas))
    error('x and data are of different size in mergeData');
  endif;
  size(xs)
  xL = -inf;
  xR = inf;
  for i = 1:size(xs,2)
    x = xs{i};
    xL = max(xL, x(1));
    indR = size(x,2);
    xR = min(xR, x(indR));
  end;
  [xdataOut, data1] = cropData(xs{1}, datas{1}, [xL,xR] );
  xdataOut = [xdataOut' data1];
  for i = 2:size(xs)(2)
    [_, data1] = cropData(xs{i}, datas{i}, [xL,xR] );
    xdataOut = [xdataOut data1];
  end;
end;
