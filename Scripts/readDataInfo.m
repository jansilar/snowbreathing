function di = readDataInfo(path)
    di.dataInfoFile = [path '/data_info.m'];
    run(di.dataInfoFile);
end

    