function flowrfpnorm = repairFlowData(flow, press, flowRepair, doPlot)
% reconstructs the flow from the pressure if the flowrepair.pc contains 
% the parameters pc or just repair the flow

    flowrfp = zeros(size(flow));
    % reconstruct raw flow - both pos and neg sides
    if isfield(flowRepair, 'pc') && all(~isnan(flowRepair.pc))
        disp('Reconstructing from the pressure...');
        pos = press >= 0;
        flowrfp( pos) =  flowRepair.pc(1).*( press( pos)).^flowRepair.pc(2);
        flowrfp(~pos) = -flowRepair.pc(1).*(-press(~pos)).^flowRepair.pc(2);
    else
        disp('Filtering the flow data...');
        % first iteration - remove invalid readings and saturation 
        flowrfp = filterFlowData(flow, flowRepair, doPlot);
        
        % exclude too small segments to prevent overfitting
        %breakPos = adjustMinimalDistances(flowRepair.manuallyInvalidated, 250, false);
        % adjust the volume
        %flowr = adjustVolumeTrend(flow2, breakPos, true);
    end
    % normalize the volume drift again
    flowrfpnorm = adjustVolumeTrend(flowrfp, doPlot);
    
    if doPlot
        figure();clf;hold on;
        plot(flow, 'b', 'Linewidth', 1);
        plot(flowrfp, 'k', 'Linewidth', 1);
        plot(flowrfpnorm, 'r', 'Linewidth', 2);
        legend('Original flow', 'reconstructed flow', 'Reconstructed with volume drift correction')
        title('Flow repair')
    end



