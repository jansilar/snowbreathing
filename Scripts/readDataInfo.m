function di = readDataInfo(baseName)
    dir = ['../Data/' baseName '/'];
    addpath(dir);
    funName = [strrep(baseName,'-','_') '_data_info'];
    clear(funName);
    funDataInfo = str2func(funName);
    di = funDataInfo();
    
    % do some postprocessing - prepare flowColumn and pressColumn
    di.W.columnFlow = 0;
    di.W.columnPress = 0;
    for i = 1:length(di.W.varName)
        if strcmp(di.W.varName{i},'Flow')
            di.W.columnFlow = i;
        elseif strcmp(di.W.varName{i},'Paw')
            di.W.columnPress = i;
        end
    end
end

    