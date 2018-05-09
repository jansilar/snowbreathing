function [] = txtToMat(file)
    pathfile = ['../Data/' file '/' file '_grad'];
    fprintf(['opening ' pathfile '.txt\n']);
    dataComplet = importdata([pathfile '.txt'],'\t',1)
    data = dataComplet.data;
    size(data);
    n = size(data,1)
    idx = (1:n)';
    r = data(:,1);
    t = data(:,2);
    CO2 = data(:,3);
    O2 = data(:,4);
    GRAD = [zeros(1,4); [t r CO2 O2]]
    
    save('-v4',[pathfile '.mat'], 'GRAD');
    fig = figure;
    hold on;
    plot(r,CO2,'+');
    plot(r,O2, 'r+');
    legend({'CO2', 'O2'})
    saveas(fig,[pathfile '.png']);
end