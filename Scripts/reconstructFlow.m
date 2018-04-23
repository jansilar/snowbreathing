function flowrfpnorm = reconstructFlow(press, flow, flowRepair, doPlot)
% reconstructs the flow from the pressure if the flowrepair.pc contains 
% the parameters pc or just repair the flow

    flowrfp = zeros(size(press));
    % reconstruct raw flow - both pos and neg sides
    if exist(flowRepair.pc, 'var') && ~isnan(flowRepair.pc)
        pos = press >= 0;
        flowrfp( pos) =  flowRepair.pc(1).*( press( pos)).^flowRepair.pc(2);
        flowrfp(~pos) = -flowRepair.pc(1).*(-press(~pos)).^flowRepair.pc(2);
    else
        % first iteration - remove invalid readings and saturation 
        flowrfp = repairFlowData(flow, flowRepair, true);
        % exclude too small segments to prevent overfitting
        %breakPos = adjustMinimalDistances(flowRepair.manuallyInvalidated, 250, false);
        % adjust the volume
        %flowr = adjustVolumeTrend(flow2, breakPos, true);
    end
    % normalize the volume drift again
    flowrfpnorm = repairFlowData22(flowrfp, doPlot);
    
    if doPlot
        figure();clf;hold on;
        flow = raw_read.data(:, df.PressFlowPos(2)).';
        plot(flow, 'b', 'Linewidth', 1);
        plot(flowrfp, 'k', 'Linewidth', 1);
        plot(co2*40 - 250, 'm')
        plot(flowrfpnorm, 'r', 'Linewidth', 2);
        legend('Original flow', 'reconstructed flow', 'CO2', 'Reconstructed with volume drift correction')
        title('Flow reconstruction from pressure')
    end   
end
