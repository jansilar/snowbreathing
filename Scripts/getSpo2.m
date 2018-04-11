%  data_dir = 'c004-8S2000';
  data_dir = 'c004-11m2000';
  file = ["..\\Data\\" data_dir "\\" data_dir 'trendsDots.asc'];
  rowsW = [30];
  fs = 1;
  
%% load data - pCO2, pO2, Flow
  data_raw_read = importdata(file,"\t",2).data(:,30);
  spo2 = data_raw_read(:, 1);
  N = length(spo2);
  spo2valid = spo2 > 10 & spo2 < 101;  
  X = (1:length(spo2));
  spo2(isnan(spo2)) = 0;
  
  spo2r = interp1(X(spo2valid), spo2(spo2valid), X, 'linear');

  figure;
  clf; hold on;
  %plot(X, spo2, 'b');
  plot(X, spo2r, 'r');
  plot(X(spo2valid), spo2r(spo2valid), 'b');
  
