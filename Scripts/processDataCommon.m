%To find and set prope crop times and the time, when cone was disconnected
% - comment out all but one calls of processOne
% - consecutively uncomment particular sections in processOne find the 
%         values and write them to data_info.m

%dir = 'c004-3m0200'; % flow repaired
% dir = 'c004-4m2000'; % flow repaired
 dir = 'c004-8S2000'; % flow repaired, , hotovo i grad - spasování vypadá dobře
% dir = 'c004-11m2000'; % flow repaired

% dir = 'c007-01m2000'; % flow repaired
% dir = 'c007-07m2000'; % flow cannot be succesefully repaired
% dir = 'c007-08s2000'; % flow repaired, hotovo i grad - chybí data z dutiny po odpojení

%dir = 'c013-001m2000'; %hotovo i grad
%dir = 'c013-12m2000'; %hotovo i grad
%dir = 'c013-12s2000'; %hotovo i grad
%  allData(dir);
setupFile = 0;
plotGrad = 0;
plotRepairFlow = 0;
inputData(dir,setupFile,plotGrad,plotRepairFlow);
