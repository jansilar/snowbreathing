function repairedFlow = repairFlowData(flow, flowRepairStruct, dbg)
% filter invalid readings and positive saturations from the flow
%
% flowRepair.invalidReading = [-0.1, -0.2, -0.2];
% flowRepair.manuallyInvalidated = ...
%  [5000, 6650, 8030:8040,10265:10292, 12500, 14500, 16300:16327, ...
%  16387:16394, 16539:16552, 16704];
% flowRepair.diffBounds = -110, 40, 20];

%defaults = {[], [], [-0.1, -0.2, -0.2], [-110, 40, 20], true};
%defaults(1:nargin) = varargin;
%
%flow = (defaults{1}); 

invalidFlowData = flowRepairStruct.manuallyInvalidated;
badReading= flowRepairStruct.invalidReading; 
% [min, max, maxwidth] - min peak of diff, max peak of diff and maximal width of sat
diffBounds= flowRepairStruct.diffBounds;

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
if ~isempty(diffBounds)
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
end

% exclude additional points manually
% it is better to do it after the automatic peak detection, 
% so we wont introduce additional high differences
sat (invalidFlowData) = false;


repairedFlow = interp1(X(sat), flow(sat), 1:N, 'pchip');
% override possible corruption of original data by interpolation smoothing
repairedFlow(sat) = flow(sat);

% filter out some NA and NaNs
repairedFlow(~isfinite(repairedFlow)) = 0;

% get the volume shift
vol = cumsum(repairedFlow)/100;

%{
figure(1)
clf;hold on; plot(flow); 
plot(flowv2, 'k'); 
plot((1:N)(!sat), flowv(!sat), '*');
plot((1:N)(sat_loc),flowvdif2(sat_loc), '*');
%}
%flowv2(sat) = flow(sat);

%% df
ms = 15;
if (dbg)
  figure(101);
  clf;hold on; 
  plot(flow, '-r') ;
  plot(repairedFlow, 'b', 'LineWidth', 2); 
  plot(flowvdif, '-g');

  % invalid readings - +
  plot(X(~flowvalid), repairedFlow(~flowvalid), 'r+', 'markersize', ms);
  
  % saturation only - X
  plot(X(~sat & flowvalid), repairedFlow(~sat & flowvalid), 'rx', 'markersize', ms);
  
  % manual exclusion - point - would overlap with sat
  plot(X(invalidFlowData), repairedFlow(invalidFlowData), 'r.', 'markersize', ms);
  
  plot(X, vol, 'k');
  plot(X(invalidFlowData), vol(invalidFlowData), 'r.', 'markersize', ms);
  legend('original Q', 'repaired Q','d Q / dx', 'invalid reading', ...
      'sat', 'manual inv', 'volume', 'manual inv')
  
end;


