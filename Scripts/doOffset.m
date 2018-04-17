function xOut = doOffset(x,offset, f)
  %round the offset to multiple of dt
  offsetR = round(offset*f)/f;
  xOut = x - offsetR;
end;
