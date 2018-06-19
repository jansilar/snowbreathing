function data = importFile(pathfile,column)
  pathfile
  impDat = importdata(pathfile,'\t',3);
  data = impDat.data(:,column);
end