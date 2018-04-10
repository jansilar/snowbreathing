function txtToMat(file)
    data = importdata([file ".txt"],"\t",2).data;
    size(data);
    r = data(:,1);
    t = data(:,2);
    CO2 = data(:,3);
    O2 = data(:,4);
    save("-v4",[file ".mat"], "r", "t", "CO2", "O2");
    figure;
    hold on;
    plot(r,CO2);
    plot(r,O2, "r");
    legend({"CO2", "O2"})