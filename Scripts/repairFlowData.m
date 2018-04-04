function repairedFlow = repairFlowData(varargin)
% filter the positive saturation from the flow
% there are sometimes -0.1 and -0.2 invalid data reads

defaults = {[], [-0.1, -0.2, -0.2], [-110, 40], 20, true};
defaults(1:nargin) = varargin;

flow = (defaults{1})'; 
badReading= defaults{2}; 
diffBounds= defaults{3};
maxWidth = defaults{4};
showPlot = defaults{5};

N = length(flow);

%% prefilter for invalid data reads and its neighbours
a = flow != badReading';
a = a(1, :) & a(2, :) & a(3, :);
flowvalid = [false, a(1:end-2) & a(2: end-1) & a(3: end), false];

flowv = interp1((1:N)(flowvalid), flow(flowvalid), 1:N, 'pchip');
flowv(flowvalid) = flow(flowvalid);
% find peaks of double derivative
flowvdif = [flowv(1:end-1) - flowv(2:end), 0];
%flowvdif2 = [0, flowvdif(1:end-1) - flowvdif(2:end)];
%sat_loc = flowvdif2 > 50 | flowvdif2 < -50;

%% filter out positive saturation - find a huge negative difference and search for a positive diff within some interval.
sat = flowvalid;
s1 = flowvdif < diffBounds(1);
s2 = [s1(1:end-1) & !(s1(2:end)), true];
for i = 1:N-maxWidth -1;
  if s2(i)
    for j = i:i+maxWidth
      if flowvdif(j) > diffBounds(2)
        % found it!
        sat(i:j+3) = false;
        %break;
      endif;
    endfor;
  endif;
endfor;

% TODO test spline inte
repairedFlow = interp1((1:N)(sat), flow(sat), 1:N, 'pchip');
repairedFlow(sat) = flow(sat);

%{
figure(1)
clf;hold on; plot(flow); 
plot(flowv2, 'k'); 
plot((1:N)(!sat), flowv(!sat), '*');
plot((1:N)(sat_loc),flowvdif2(sat_loc), '*');
%}
%flowv2(sat) = flow(sat);
if showPlot
  clf;hold on; 
  plot(flow, '-r') ;
  plot(flowvdif, '-g');
  plot(repairedFlow, 'b', 'LineWidth', 2); 
  plot((1:N)((!sat)), repairedFlow(!sat), 'r*');
endif

%% filter out some NA and NaNs
repairedFlow(!isfinite(repairedFlow)) = 0;

endfunction