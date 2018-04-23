function [x2,data2] = resampleX(data,f1,f2)
%resample function:
  if f1 == f2
      x2 = createX(data,f1,f1);
      data2 = data;
  elseif rem(f1,f2) == 0 %
      'downsample\n'
      n = f1/f2;
      data2 = avgDownSample(data,n);
      x2 = createX(data2,f2,f2);

      'x2\n'
      size(x2)
      'data2\n'
      size(data2)
  else
    x1 = createX(data,f1,f1);
    x2 = createX(data,f1,f2);
    data2 = interp1(x1,data,x2,'linear');
  end;
end