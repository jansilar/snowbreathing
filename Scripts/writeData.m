function writeData(data, header, file)
  textHeader = strjoin(header, '\t');
  %write header to file
  fid = fopen(file,'w')
  fprintf(fid,'%s\n',textHeader)
  fclose(fid)
  %write data to end of file
  dlmwrite(file,data,'\t', '-append')
  ['data written to ' file ' file\n']
end;
