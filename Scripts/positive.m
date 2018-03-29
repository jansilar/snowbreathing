function positiveVector = positive(vector)
  positiveVector = zeros(size(vector));
  positiveVector(vector >= 0) = vector(vector >= 0);
 endfunction;
  