function flowrfpnorm = reconstructFlow(press, pc, doPlot)
%% reconstructs the flow from the pressure

    pos = press >= 0;
    flowrfp( pos) =  pc(1).*( press( pos)).^pc(2);
    flowrfp(~pos) = -pc(1).*(-press(~pos)).^pc(2);
    
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
