function [powerCoeff, rms] = fitResistancePower(flow, pressure, doPlot)
%% fit the power function to the flow and pressure XY 
% N = length(pressure)
% X = 1:N;

%% prepare positive quadrants and filter out half-negatives
PQ = [pressure; flow];
poslines = pressure > 0 & flow > 0;
neglines = pressure < 0 & flow < 0;
PQp = PQ(:, poslines );
PQn = PQ(:, neglines );

%% prepare the fit vectors
PQ1Sided = [PQp, -PQn];
pfit = PQ1Sided(1, :);
ffit = PQ1Sided(2, :);

[powerfit, validity] = fit(pfit', ffit', 'a*x^b');
powerCoeff = [powerfit.a, powerfit.b];
rms = validity.rsquare;

if doPlot
    figure(); 
    clf; hold on;
    xp = (0:0.1:max(pressure));

    plot(PQp(1, :), PQp(2, :), 'bo');
    plot(-PQn(1, :), -PQn(2, :), 'm*');
    % observe fit
    plot(xp, powerfit.a*xp.^powerfit.b, 'k-', 'linewidth', 4);
    legend('exhale', 'inhale', 'power fit')
end
