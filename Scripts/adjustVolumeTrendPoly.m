function flowr = adjustVolumeTrendPoly(flow, breakPos, dbg)
% adjustvolume trend by picewise polynomial

N = length(flow);
X = 1:N;

%integrate flow to get vol
vol = cumsum(flow);

tt = zeros(1, N);
% piecewise remove nonlinear trends
for i = 1:length(breakPos)-1
  chunk = breakPos(i):breakPos(i+1);
  
  chunkX = 1:length(chunk);
  [p, s, mu] = polyfit(chunkX, vol(chunk), 3);
  tt(chunk) = polyval(p,chunkX,[],mu);
end


tt2 = tt;

% NOT NOW invalidate all the manualy invalid intervals, except first and last
% tt2(mis(2:end-1)) = nan;

% and its right neighbours - there is probably data error
% the value rougly imitates breath length
ngb = 40;
for i = breakPos(1:end)
  tt2(i: i+ngb) = nan;
end
% interpolate the nans by spline
tt3 = interp1(X(~isnan(tt2)), tt2(~isnan(tt2)), X, 'spline');

% use the smooth curve to repair the vol
volr = vol - tt3;
% and reconstruct the flow
flowr = [0, diff(volr)];

% reconstructed volume - just for check
rvol = cumsum([0 diff(volr)]);

if dbg
  figure;
  clf; hold on;
  plot(X, vol)
  plot(X, tt, 'k')
  plot(X, tt3, 'k', 'Linewidth', 2);
  plot(X(breakPos), tt3(breakPos), 'kx', 'Markersize', 14)

  plot(X, flow*50, 'b')
  plot(X, flowr*50, 'r')

  plot(X, rvol, 'm')
end