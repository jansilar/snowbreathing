function breakPos = adjustMinimalDistances(manualInvalidated, minDist, varargin)


defaults = {false};

if nargin >= 3
  defaults(nargin-2) = varargin;
end  

dbg = defaults{1};
  

  
N = manualInvalidated(end);
X = 1:N;

% also include start and the end of the signal
%mis = [1, sort(manualInvalidated), N];
mis = sort(manualInvalidated);
% manually insert start and end positions
breaks = [true, diff(diff(mis)) ~= 0, true];

breakPos = mis(breaks);

nBp = length(breakPos);
keepBp = true(1, length(breakPos));

if dbg
  figure; 
  clf; hold on;
  plot(X(breakPos), zeros(1, N)(breakPos), 'bo', 'MarkerSize', 8);
end


for i = 1:nBp-2
  breakPos = breakPos(keepBp);
  keepBp = true(1, length(breakPos));
  d = diff(breakPos);
  m = min(d);
  
  if m > minDist
    % end the loop when the minimal distance is longer than some min
    break;
  end
  
  minpos = find(d == m);
  for j = minpos,
    if j == 1
      % the beginning is laways right 
      keepBp(2) = false;
    elseif j == length(d)
      % and the end is always left
      keepBp(j) = false;
    elseif breakPos(j+1) - breakPos(j-1) >= breakPos(j+2) - breakPos(j)
      % the right has larger then the left, thus cut out the left
      keepBp(j+1) = false;
    else
      % cut out the right neighbours
      keepBp(j) = false;
    end
  end

  if dbg
    plot(X(breakPos(~keepBp)), zeros(1, N)((breakPos(~keepBp))), 'r*', 'MarkerSize', 12);
    disp('Press enter...');
    pause;
  end
  
end
