function di = readDataInfo(baseName)
    dir = ['../Data/' baseName '/'];
    addpath(dir);
    funName = [strrep(baseName,'-','_') '_data_info'];
    clear(funName);
    funDataInfo = str2func(funName);
    di = funDataInfo();
end

    