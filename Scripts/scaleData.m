function data = scaleData(scale, data)
  %bl - base line, sf - scale factor:
  blCO2 = scale(1);
  sfCO2 = scale(2);
  blO2 = scale(3);
  sfO2 = scale(4);
  data(:,1) = (data(:,1) - blCO2)*sfCO2 + blCO2;
  data(:,2) = (data(:,2) - blO2)*sfO2 + blO2;
end
  