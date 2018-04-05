function repairedFlow = repairFlowData(varargin)
% filter the positive saturation from the flow
% there are sometimes -0.1 and -0.2 invalid data reads

defaults = {[], [], [-0.1, -0.2, -0.2], [-110, 40, 20], true};
defaults(1:nargin) = varargin;

flow = (defaults{1}); 
invalidFlowData = defaults{2};
badReading= defaults{3}; 
% [min, max, maxwidth] - min peak of diff, max peak of diff and maximal width of sat
diffBounds= defaults{4};
showPlot = defaults{5};

N = length(flow);
X = (1:N);

%% prefilter for invalid data reads and its neighbours
a = true(size(flow));
for i = 1:length(badReading),
    a = flow ~= badReading(i) & a;
end;
flowvalid = [false(1), a(1:end-2) & a(2: end-1) & a(3: end), false];

flowv = interp1(X(flowvalid), flow(flowvalid), 1:N, 'pchip');
flowv(flowvalid) = flow(flowvalid);
% find peaks of double derivative
flowvdif = [flowv(1:end-1) - flowv(2:end), 0];
%flowvdif2 = [0, flowvdif(1:end-1) - flowvdif(2:end)];
%sat_loc = flowvdif2 > 50 | flowvdif2 < -50;

%% filter out positive saturation - find a huge negative difference and search for a positive diff within some interval.
sat = flowvalid;
s1 = flowvdif < diffBounds(1);
s2 = [s1(1:end-1) & ~(s1(2:end)), true];
for i = 1:N-diffBounds(3) -1;
  if s2(i)
    for j = i:i+diffBounds(3)
      if flowvdif(j) > diffBounds(2)
        % found it!
        sat(i:j+1) = false;
      end;
    end;
  end
end;


% exclude additional points manually
sat (invalidFlowData) = false;


repairedFlow = interp1(X(sat), flow(sat), 1:N, 'pchip');
repairedFlow(sat) = flow(sat);

%{
figure(1)
clf;hold on; plot(flow); 
plot(flowv2, 'k'); 
plot((1:N)(!sat), flowv(!sat), '*');
plot((1:N)(sat_loc),flowvdif2(sat_loc), '*');
%}
%flowv2(sat) = flow(sat);

%% df
if (showPlot)
  clf;hold on; 
  plot(flow, '-r') ;
  plot(flowvdif, '-g');
  plot(repairedFlow, 'b', 'LineWidth', 2); 
  plot(flowvdif, '-g');

  plot(X(~sat), repairedFlow(~sat), 'r*');
end;

%% filter out some NA and NaNs
repairedFlow(~isfinite(repairedFlow)) = 0;

