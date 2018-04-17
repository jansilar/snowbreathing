function allData(dir)
  %read the dataInfo file:
  filePath = ['../Data/' dir '/']
  run([filePath '/data_info.m'])

  files = {fileT; fileTD; fileW; fileWD};
  %frequencies:
  f = [fT fTD fW fWD];
  %offsets = [offsetT offsetTD offsetW offsetWD];

  close all;
  [xT, dataT] = processOne(fileT, columnT, filePath, fT , fTarget, cropT, tEndT, varIT, varNameT, -1);
  [xW, dataW] = processOne(fileW, columnW, filePath, fW , fTarget, cropW, tEndW, varIW, varNameW, -1);
  [xWD, dataWD] = processOne(fileWD, columnWD, filePath, fWD, fTarget, cropWD, tEndWD, varIWD, varNameWD, -1);

  xdata = mergeData({xT, xW, xWD}, {dataT, dataW, dataWD});
  %xdata = mergeData({xT, xW}, {dataT, dataW});
  %error('debug')
  varNames = [varNameT, varNameW, varNameWD]
  figure;
  hold on;
  plotData(xdata, varNames, [3, 4,  8, 9], [1, 1, 1, 1], 'x');

  writeData(xdata, ['t' varNames], [filePath dir '_all.txt'])
end;
