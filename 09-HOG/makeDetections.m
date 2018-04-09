function makeDetections(w, hogCellSize, scales)

tsPath = 'ValImages';
tsDir = dir(tsPath);
evalDir = 'eval_tools_Lab9/evalBoxes';

for i = 3:length(tsDir)
    className = tsDir(i).name;
    classPath = fullfile(tsPath, className, '*.jpg');
    classDir = dir(classPath);
    for j = 1:length(classDir)
        ruta = fullfile(tsPath, className, classDir(j).name);
        im = imread(ruta);
        im = single(im);
        [detections, scores] = detect(im, w, hogCellSize, scales) ;
        keep = boxsuppress(detections, scores, 0.25) ;
        detections = detections(:, keep(1:10)) ;
        scores = scores(keep(1:10)) ;
        
        imName = classDir(j).name;
        imName = strsplit(imName, '.');
        imName = imName{1};
        
        numDetections = size(detections, 2);
        
%         detections = detections';
%         scores = scores';
        
        detections(3, :) = detections(3, :) - detections(1, :);
        detections(4, :) = detections(4, :) - detections(2, :);
        
        totalDetections = zeros(5, numDetections);
        totalDetections(1:4, :) = detections;
        totalDetections(5, :) = scores;
        
        fileName = fullfile(evalDir, className, strcat(imName, '.txt'));
        fileID = fopen(fileName, 'w+');
        fprintf(fileID,'%s\r\n', imName);
        fprintf(fileID,'%u\r\n', numDetections);
        fprintf(fileID,'%f %f %f %f %f\r\n', totalDetections);
        fclose(fileID);
    end
end

end