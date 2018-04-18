function di = updateDataInfo(diIn)
    diIn.dataInfoFile
    run(diIn.dataInfoFile);
    di
    di.W
    'updated'
    pause()
    di.dataInfoFile = diIn.dataInfoFile;
end