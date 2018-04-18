function data = importFile(pathfile,column)
  impDat = importdata(pathfile,'\t',3);
  data = impDat.data(:,column);
end