%To find and set prope crop times and the time, when cone was disconnected
% - comment out all but one calls of processOne
% - consecutively uncomment particular sections in processOne find the 
%         values and write them to data_info.m

% dir = 'c004-3m0200'; % flow repaired, nema data z dutiny, jak se dela grad?
% dir = 'c004-4m2000'; % flow repaired, hotovo i grad, v dutině úplný sračky
% dir = 'c004-8S2000'; % flow repaired, , hotovo i grad - spasování vypadá dobře
%IDENTIFIKOVANO
 dir = 'c004-11m2000'; % flow repaired, spasovano - vypadá dobře
 

% dir = 'c007-01m2000'; % flow repaired, spasovano, chybi ale cast flow dat nekde vprostred
% dir = 'c007-07m2000'; % flow cannot be succesefully repaired
 %dir = 'c007-08s2000'; % flow repaired, hotovo i grad - chybí data z dutiny po odpojení, spasování vypadá středně

dir = 'c013-001m2000'; %hotovo i grad - přeškálováno
%dir = 'c013-12m2000'; %hotovo i grad - přeškálováno
%dir = 'c013-12s2000'; %hotovo i grad - přeškálováno
%  allData(dir);
setupFile = 0;
plotGrad = 0;
plotRepairFlow = 0;
% inputData(dir,setupFile,plotGrad,plotRepairFlow);

dirs = {'c004-4m2000';'c004-8S2000';'c004-11m2000';'c007-01m2000';'c007-08s2000';'c013-001m2000';'c013-12m2000';'c013-12s2000'};
for i=1:numel(dirs)
   dir = dirs{i};
   ['processing ' dir ' data set\n']
   inputData(dir,setupFile,plotGrad,plotRepairFlow);
end;
